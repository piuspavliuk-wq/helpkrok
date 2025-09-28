'use client';

import { useState, useEffect, useCallback } from 'react';
import { useSession } from 'next-auth/react';
import { Folder, Plus, Trash2, Edit, Eye, BookOpen, Share2, GripVertical } from 'lucide-react';
import Link from 'next/link';
import ConfirmationModal from '@/components/ui/confirmation-modal';
import {
  DndContext,
  closestCenter,
  KeyboardSensor,
  PointerSensor,
  TouchSensor,
  useSensor,
  useSensors,
  DragEndEvent,
  DragStartEvent,
  DragOverlay,
} from '@dnd-kit/core';
import {
  arrayMove,
  SortableContext,
  sortableKeyboardCoordinates,
  verticalListSortingStrategy,
} from '@dnd-kit/sortable';
import {
  useSortable,
} from '@dnd-kit/sortable';
import { CSS } from '@dnd-kit/utilities';

interface Folder {
  id: string;
  name: string;
  description: string;
  color: string;
  created_at: string;
  question_count?: number;
  position?: number;
  stats?: {
    total_questions: number;
    krok_questions: number;
    anatomy_questions: number;
    histology_questions: number;
  };
}

interface SortableFolderProps {
  folder: Folder;
  onDelete: (folderId: string) => void;
}

function SortableFolder({ folder, onDelete }: SortableFolderProps) {
  const {
    attributes,
    listeners,
    setNodeRef,
    transform,
    transition,
    isDragging,
  } = useSortable({ id: folder.id });

  const style = {
    transform: CSS.Transform.toString(transform),
    transition,
    opacity: isDragging ? 0.5 : 1,
  };

  return (
    <div
      ref={setNodeRef}
      style={style}
      className="bg-white rounded-lg p-4 shadow-sm hover:shadow-md transition-all duration-200"
    >
      <div className="flex items-center space-x-4">
        {/* Drag handle */}
        <div
          {...attributes}
          {...listeners}
          className="cursor-move text-gray-400 hover:text-gray-600 transition-colors duration-200 hover:scale-110 transform touch-none"
        >
          <GripVertical className="w-5 h-5" />
        </div>
        
        {/* Клікабельна назва папки */}
        <Link
          href={`/folders/${folder.id}`}
          className="flex-1 cursor-pointer hover:bg-gray-50 p-2 rounded-lg transition-colors"
        >
          <h3 className="text-lg font-semibold text-gray-900 mb-1">{folder.name}</h3>
          <p className="text-sm text-gray-600">Питань: {folder.stats?.total_questions || 0}</p>
        </Link>
        
        {/* Кнопка видалення */}
        <button
          onClick={(e) => {
            e.stopPropagation();
            onDelete(folder.id);
          }}
          className="p-2 text-gray-400 hover:text-red-600 hover:bg-red-50 rounded-lg transition-colors"
          title="Видалити"
        >
          <Trash2 className="w-4 h-4" />
        </button>
      </div>
    </div>
  );
}

export default function FoldersPage() {
  const { data: session } = useSession();
  const [folders, setFolders] = useState<Folder[]>([]);
  const [loading, setLoading] = useState(true);
  const [showCreateModal, setShowCreateModal] = useState(false);
  const [newFolder, setNewFolder] = useState({
    name: '',
    description: '',
    color: '#3B82F6'
  });
  const [saving, setSaving] = useState(false);
  const [activeId, setActiveId] = useState<string | null>(null);
  const [showDeleteModal, setShowDeleteModal] = useState(false);
  const [folderToDelete, setFolderToDelete] = useState<{id: string, name: string} | null>(null);

  const sensors = useSensors(
    useSensor(PointerSensor, {
      activationConstraint: {
        distance: 0,
      },
    }),
    useSensor(TouchSensor, {
      activationConstraint: {
        delay: 50,
        tolerance: 8,
      },
    }),
    useSensor(KeyboardSensor, {
      coordinateGetter: sortableKeyboardCoordinates,
    })
  );

  // Завантаження папок
  useEffect(() => {
    if (session?.user?.id) {
      loadFolders();
    }
  }, [session]);

  const loadFolders = async () => {
    setLoading(true);
    try {
      const response = await fetch('/api/folders');
      if (response.ok) {
        const data = await response.json();
        // Сортуємо папки за позицією
        const sortedFolders = (data.folders || []).sort((a: Folder, b: Folder) => {
          const posA = a.position ?? 0;
          const posB = b.position ?? 0;
          return posA - posB;
        });
        setFolders(sortedFolders);
      }
    } catch (error) {
      console.error('Error loading folders:', error);
    } finally {
      setLoading(false);
    }
  };

  // Створення нової папки
  const createFolder = async () => {
    if (!newFolder.name.trim()) return;
    
    setSaving(true);
    try {
      const response = await fetch('/api/folders', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(newFolder)
      });

      if (response.ok) {
        const data = await response.json();
        setFolders(prev => [data.folder, ...prev]);
        setNewFolder({ name: '', description: '', color: '#3B82F6' });
        setShowCreateModal(false);
        alert('Папку створено успішно!');
      } else {
        const errorData = await response.json();
        alert(`Помилка: ${errorData.error || 'Не вдалося створити папку'}`);
      }
    } catch (error) {
      console.error('Error creating folder:', error);
      alert('Помилка при створенні папки');
    } finally {
      setSaving(false);
    }
  };

  // Видалення папки
  const deleteFolder = (folderId: string) => {
    const folder = folders.find(f => f.id === folderId);
    if (folder) {
      setFolderToDelete({
        id: folderId,
        name: folder.name
      });
      setShowDeleteModal(true);
    }
  };

  const handleConfirmDeleteFolder = async () => {
    if (!folderToDelete) return;
    
    setSaving(true);
    try {
      const response = await fetch(`/api/folders/${folderToDelete.id}`, {
        method: 'DELETE'
      });

      if (response.ok) {
        setFolders(prev => prev.filter(f => f.id !== folderToDelete.id));
      } else {
        const errorData = await response.json();
        alert(`Помилка: ${errorData.error || 'Не вдалося видалити папку'}`);
      }
    } catch (error) {
      console.error('Error deleting folder:', error);
      alert('Помилка при видаленні папки');
    } finally {
      setSaving(false);
      setShowDeleteModal(false);
      setFolderToDelete(null);
    }
  };

  const handleCancelDeleteFolder = () => {
    setShowDeleteModal(false);
    setFolderToDelete(null);
  };

  // Функції для перетягування

  const handleDragStart = useCallback((event: DragStartEvent) => {
    setActiveId(event.active.id as string);
  }, []);

  const handleDragEnd = useCallback(async (event: DragEndEvent) => {
    const { active, over } = event;

    setActiveId(null);

    if (active.id !== over?.id) {
      const oldIndex = folders.findIndex(folder => folder.id === active.id);
      const newIndex = folders.findIndex(folder => folder.id === over?.id);

      const newFolders = arrayMove(folders, oldIndex, newIndex);
      
      // Оновлюємо позиції
      const updatedFolders = newFolders.map((folder, index) => ({
        ...folder,
        position: index
      }));
      
      setFolders(updatedFolders);
      
      // Зберігаємо позиції в Supabase
      await saveFolderPositions(updatedFolders);
    }
  }, [folders]);

  // Функція для збереження позицій папок
  const saveFolderPositions = useCallback(async (foldersToSave: Folder[]) => {
    try {
      const updates = foldersToSave.map(folder => ({
        id: folder.id,
        position: folder.position || 0
      }));

      const response = await fetch('/api/folders/positions', {
        method: 'PUT',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ folders: updates })
      });

      if (!response.ok) {
        console.error('Failed to save folder positions');
      }
    } catch (error) {
      console.error('Error saving folder positions:', error);
    }
  }, []);

  if (!session?.user?.id) {
    return (
      <div className="min-h-screen bg-gradient-to-br from-blue-50 via-blue-50 to-blue-100 flex items-center justify-center">
        <div className="text-center">
          <h1 className="text-2xl font-bold text-gray-900 mb-4">Увійдіть в систему</h1>
          <p className="text-gray-600 mb-6">Для доступу до папок потрібно увійти в систему</p>
          <Link
            href="/auth/signin"
            className="bg-blue-600 text-white px-6 py-3 rounded-lg hover:bg-blue-700 transition-colors"
          >
            Увійти
          </Link>
        </div>
      </div>
    );
  }

  return (
    <div className="min-h-screen bg-gradient-to-br from-blue-50 via-blue-50 to-blue-100">
      <div className="p-6">
        <div className="max-w-6xl mx-auto">
          {/* Заголовок */}
          <div className="flex justify-between items-center mb-6">
            <h1 className="text-2xl font-bold text-gray-900">Мої папки</h1>
            <button
              onClick={() => setShowCreateModal(true)}
              className="bg-blue-600 text-white px-4 py-2 rounded-lg hover:bg-blue-700 transition-colors flex items-center space-x-2"
            >
              <Plus className="w-5 h-5" />
              <span>Створити</span>
            </button>
          </div>

          {/* Список папок */}
          {loading ? (
            <div className="space-y-4">
              {[...Array(6)].map((_, i) => (
                <div key={i} className="bg-white rounded-lg p-4 shadow-sm animate-pulse">
                  <div className="flex items-center space-x-4">
                    <div className="w-4 h-4 bg-gray-200 rounded"></div>
                    <div className="w-6 h-6 bg-gray-200 rounded"></div>
                    <div className="flex-1">
                      <div className="h-4 bg-gray-200 rounded mb-2"></div>
                      <div className="h-3 bg-gray-200 rounded w-1/3"></div>
                    </div>
                    <div className="flex space-x-2">
                      <div className="w-6 h-6 bg-gray-200 rounded"></div>
                      <div className="w-6 h-6 bg-gray-200 rounded"></div>
                      <div className="w-6 h-6 bg-gray-200 rounded"></div>
                    </div>
                  </div>
                </div>
              ))}
            </div>
          ) : folders.length === 0 ? (
            <div className="text-center py-12">
              <Folder className="w-16 h-16 text-gray-400 mx-auto mb-4" />
              <h3 className="text-xl font-semibold text-gray-900 mb-2">Немає папок</h3>
              <p className="text-gray-600 mb-6">Створіть першу папку для організації питань</p>
              <button
                onClick={() => setShowCreateModal(true)}
                className="bg-blue-600 text-white px-6 py-3 rounded-lg hover:bg-blue-700 transition-colors"
              >
                Створити папку
              </button>
            </div>
          ) : (
            <DndContext
              sensors={sensors}
              collisionDetection={closestCenter}
              onDragStart={handleDragStart}
              onDragEnd={handleDragEnd}
            >
              <SortableContext items={folders.map(f => f.id)} strategy={verticalListSortingStrategy}>
                <div className="space-y-4">
                  {folders.map((folder) => (
                    <SortableFolder
                      key={folder.id}
                      folder={folder}
                      onDelete={deleteFolder}
                    />
                  ))}
                </div>
              </SortableContext>
              <DragOverlay>
                {activeId ? (
                  <div className="bg-white rounded-lg p-4 shadow-lg border border-gray-200">
                    <div className="flex items-center space-x-4">
                      <div className="cursor-move text-gray-400">
                        <GripVertical className="w-5 h-5" />
                      </div>
                      <div className="flex-1">
                        <h3 className="text-lg font-semibold text-gray-900 mb-1">
                          {folders.find(f => f.id === activeId)?.name}
                        </h3>
                        <p className="text-sm text-gray-600">
                          Питань: {folders.find(f => f.id === activeId)?.stats?.total_questions || 0}
                        </p>
                      </div>
                    </div>
                  </div>
                ) : null}
              </DragOverlay>
            </DndContext>
          )}

          {/* Модальне вікно створення папки */}
          {showCreateModal && (
            <div className="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50">
              <div className="bg-white rounded-xl p-6 w-full max-w-md mx-4">
                <h2 className="text-xl font-semibold text-gray-900 mb-4">Створити папку</h2>
                
                <div className="space-y-4">
                  <div>
                    <label className="block text-sm font-medium text-gray-700 mb-2">
                      Назва папки
                    </label>
                    <input
                      type="text"
                      value={newFolder.name}
                      onChange={(e) => setNewFolder(prev => ({ ...prev, name: e.target.value }))}
                      className="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500"
                      placeholder="Введіть назву папки"
                    />
                  </div>
                  
                  <div>
                    <label className="block text-sm font-medium text-gray-700 mb-2">
                      Опис (необов'язково)
                    </label>
                    <textarea
                      value={newFolder.description}
                      onChange={(e) => setNewFolder(prev => ({ ...prev, description: e.target.value }))}
                      className="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500"
                      rows={3}
                      placeholder="Введіть опис папки"
                    />
                  </div>
                  
                  <div>
                    <label className="block text-sm font-medium text-gray-700 mb-2">
                      Колір
                    </label>
                    <div className="flex space-x-2">
                      {['#3B82F6', '#10B981', '#F59E0B', '#EF4444', '#8B5CF6', '#06B6D4'].map((color) => (
                        <button
                          key={color}
                          onClick={() => setNewFolder(prev => ({ ...prev, color }))}
                          className={`w-8 h-8 rounded-full border-2 ${
                            newFolder.color === color ? 'border-gray-400' : 'border-gray-200'
                          }`}
                          style={{ backgroundColor: color }}
                        />
                      ))}
                    </div>
                  </div>
                </div>
                
                <div className="flex justify-end space-x-3 mt-6">
                  <button
                    onClick={() => setShowCreateModal(false)}
                    className="px-4 py-2 text-gray-600 hover:text-gray-800 transition-colors"
                  >
                    Скасувати
                  </button>
                  <button
                    onClick={createFolder}
                    disabled={saving || !newFolder.name.trim()}
                    className="px-4 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700 disabled:opacity-50 disabled:cursor-not-allowed transition-colors"
                  >
                    {saving ? 'Створення...' : 'Створити'}
                  </button>
                </div>
              </div>
            </div>
          )}
        </div>
      </div>

      {/* Модальне вікно підтвердження видалення папки */}
      <ConfirmationModal
        isOpen={showDeleteModal}
        onClose={handleCancelDeleteFolder}
        onConfirm={handleConfirmDeleteFolder}
        title="Видалення папки"
        message={folderToDelete ? `Ви впевнені, що хочете видалити папку "${folderToDelete.name}"? Всі питання в цій папці також будуть видалені.` : "Ви впевнені, що хочете видалити цю папку?"}
        confirmText="Видалити"
        cancelText="Скасувати"
        isLoading={saving}
      />
    </div>
  );
}