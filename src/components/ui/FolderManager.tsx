'use client';

import { useState, useEffect } from 'react';
import { Button } from '@/components/ui/button';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
// Використовуємо прості HTML елементи замість UI компонентів
import { 
  Folder, 
  FolderPlus, 
  Edit, 
  Trash2, 
  Plus,
  X,
  Bookmark,
  BookmarkCheck
} from 'lucide-react';

interface Folder {
  id: string;
  name: string;
  description?: string;
  color: string;
  created_at: string;
  stats: {
    total_questions: number;
    krok_questions: number;
    anatomy_questions: number;
    histology_questions: number;
  };
}

interface FolderManagerProps {
  questionId: number;
  questionType: 'krok' | 'anatomy' | 'histology';
  isSaved: boolean;
  onSaveChange: (saved: boolean) => void;
}

export default function FolderManager({ 
  questionId, 
  questionType, 
  isSaved, 
  onSaveChange 
}: FolderManagerProps) {
  const [folders, setFolders] = useState<Folder[]>([]);
  const [showCreateModal, setShowCreateModal] = useState(false);
  const [showFolderList, setShowFolderList] = useState(false);
  const [loading, setLoading] = useState(false);
  const [saving, setSaving] = useState(false);
  
  // Форма створення папки
  const [newFolder, setNewFolder] = useState({
    name: '',
    description: '',
    color: '#3B82F6'
  });

  // Завантаження папок
  const loadFolders = async () => {
    setLoading(true);
    try {
      const response = await fetch('/api/folders-simple');
      if (response.ok) {
        const data = await response.json();
        setFolders(data.folders || []);
      } else {
        console.error('Error loading folders:', response.status, response.statusText);
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
      const response = await fetch('/api/folders-simple', {
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

  // Додавання питання до папки
  const addToFolder = async (folderId: string) => {
    setSaving(true);
    try {
      const response = await fetch('/api/folders/questions', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
          folderId,
          questionType,
          questionId
        })
      });

      if (response.ok) {
        onSaveChange(true);
        setShowFolderList(false);
        // Показуємо повідомлення про успіх
        alert('Питання додано до папки!');
      } else {
        const errorData = await response.json();
        alert(`Помилка: ${errorData.error || 'Не вдалося додати питання до папки'}`);
      }
    } catch (error) {
      console.error('Error adding to folder:', error);
      alert('Помилка при додаванні питання до папки');
    } finally {
      setSaving(false);
    }
  };

  // Видалення питання з папки
  const removeFromFolder = async (folderId: string) => {
    setSaving(true);
    try {
      const response = await fetch(`/api/folders/questions?folderId=${folderId}&questionType=${questionType}&questionId=${questionId}`, {
        method: 'DELETE'
      });

      if (response.ok) {
        onSaveChange(false);
        setShowFolderList(false);
      }
    } catch (error) {
      console.error('Error removing from folder:', error);
    } finally {
      setSaving(false);
    }
  };

  useEffect(() => {
    if (showFolderList) {
      loadFolders();
    }
  }, [showFolderList]);

  return (
    <>
      {/* Кнопка папки */}
      <button
        onClick={() => setShowFolderList(!showFolderList)}
        disabled={saving}
        className="p-2 hover:bg-gray-100 rounded focus:outline-none focus:ring-0 transition-colors duration-200 disabled:opacity-50"
        title="Додати до папки"
      >
        {saving ? (
          <div className="animate-spin rounded-full h-4 w-4 border-b-2 border-gray-600"></div>
        ) : (
          <Folder className="w-4 h-4 text-blue-600" />
        )}
      </button>

      {/* Список папок */}
      {showFolderList && (
        <div className="absolute right-0 top-full mt-2 w-80 bg-white rounded-lg shadow-xl border border-gray-200 z-[9999]">
          <div className="p-4">
            <div className="flex items-center justify-between mb-4">
              <h3 className="font-semibold text-gray-800">Папки</h3>
              <div className="flex space-x-2">
                <button
                  onClick={() => setShowCreateModal(true)}
                  className="p-1 hover:bg-gray-100 rounded"
                  title="Створити папку"
                >
                  <FolderPlus className="w-4 h-4 text-blue-600" />
                </button>
                <button
                  onClick={() => setShowFolderList(false)}
                  className="p-1 hover:bg-gray-100 rounded"
                >
                  <X className="w-4 h-4" />
                </button>
              </div>
            </div>

            {loading ? (
              <div className="text-center py-4">
                <div className="animate-spin rounded-full h-6 w-6 border-b-2 border-blue-600 mx-auto"></div>
              </div>
            ) : folders.length === 0 ? (
              <div className="text-center py-4 text-gray-500">
                <Folder className="w-8 h-8 mx-auto mb-2 text-gray-300" />
                <p>Немає папок</p>
                <p className="text-sm">Створіть першу папку</p>
              </div>
            ) : (
              <div className="space-y-2 max-h-64 overflow-y-auto">
                {folders.map((folder) => (
                  <div
                    key={folder.id}
                    className="flex items-center justify-between p-3 hover:bg-gray-50 rounded-lg border"
                  >
                    <div className="flex items-center space-x-3">
                      <div 
                        className="w-4 h-4 rounded"
                        style={{ backgroundColor: folder.color }}
                      ></div>
                      <div>
                        <p className="font-medium text-sm">{folder.name}</p>
                        <p className="text-xs text-gray-500">
                          {folder.stats?.total_questions || 0} питань
                        </p>
                      </div>
                    </div>
                    <button
                      onClick={() => addToFolder(folder.id)}
                      disabled={saving}
                      className="p-1 hover:bg-blue-100 rounded text-blue-600"
                      title="Додати до папки"
                    >
                      <Plus className="w-4 h-4" />
                    </button>
                  </div>
                ))}
              </div>
            )}
          </div>
        </div>
      )}

      {/* Модальне вікно створення папки */}
      {showCreateModal && (
        <div className="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-[10000]">
          <Card className="w-96">
            <CardHeader>
              <div className="flex items-center justify-between">
                <CardTitle>Створення нової папки</CardTitle>
                <button
                  onClick={() => setShowCreateModal(false)}
                  className="p-1 hover:bg-gray-100 rounded"
                >
                  <X className="w-4 h-4" />
                </button>
              </div>
            </CardHeader>
            <CardContent className="space-y-4">
              <div>
                <label htmlFor="folder-name" className="block text-sm font-medium text-gray-700 mb-1">
                  Назва папки
                </label>
                <input
                  id="folder-name"
                  type="text"
                  value={newFolder.name}
                  onChange={(e) => setNewFolder(prev => ({ ...prev, name: e.target.value }))}
                  placeholder="Введіть назву папки"
                  className="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500"
                />
              </div>
              
              <div>
                <label htmlFor="folder-description" className="block text-sm font-medium text-gray-700 mb-1">
                  Опис (необов'язково)
                </label>
                <textarea
                  id="folder-description"
                  value={newFolder.description}
                  onChange={(e) => setNewFolder(prev => ({ ...prev, description: e.target.value }))}
                  placeholder="Опис папки"
                  rows={3}
                  className="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500"
                />
              </div>

              <div>
                <label htmlFor="folder-color" className="block text-sm font-medium text-gray-700 mb-1">
                  Колір
                </label>
                <div className="flex space-x-2">
                  {['#3B82F6', '#10B981', '#F59E0B', '#EF4444', '#8B5CF6', '#06B6D4'].map((color) => (
                    <button
                      key={color}
                      onClick={() => setNewFolder(prev => ({ ...prev, color }))}
                      className={`w-8 h-8 rounded-full border-2 ${
                        newFolder.color === color ? 'border-gray-800' : 'border-gray-300'
                      }`}
                      style={{ backgroundColor: color }}
                    />
                  ))}
                </div>
              </div>

              <div className="flex space-x-2 pt-4">
                <Button
                  onClick={createFolder}
                  disabled={!newFolder.name.trim() || saving}
                  className="flex-1"
                >
                  {saving ? 'Створення...' : 'Створити'}
                </Button>
                <Button
                  variant="outline"
                  onClick={() => setShowCreateModal(false)}
                  className="flex-1"
                >
                  Скасувати
                </Button>
              </div>
            </CardContent>
          </Card>
        </div>
      )}
    </>
  );
}
