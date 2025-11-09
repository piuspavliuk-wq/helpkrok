'use client';

import { useState, useEffect } from 'react';
import { 
  Folder, 
  FolderPlus, 
  Plus,
  X
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
    pharmaceutical_questions: number;
  };
}

interface FolderManagerProps {
  questionId: number | string;
  questionType: 'anatomy' | 'histology' | 'krok' | 'biology' | 'microbiology' | 'pharmacology' | 'physiology' | 'pathophysiology' | 'pathology' | 'pathomorphology' | 'pharmaceutical' | 'microbiology-pharmaceutical' | 'biochemistry-pharmaceutical' | 'pharmacology-pharmaceutical' | 'botany-pharmaceutical' | 'pathophysiology-pharmaceutical' | 'physical-chemistry-pharmaceutical' | 'organic-chemistry-pharmaceutical';
  isSaved?: boolean;
  onSaveChange: (saved: boolean) => void;
}

export default function FolderManager({ 
  questionId, 
  questionType, 
  onSaveChange 
}: FolderManagerProps) {
  const [folders, setFolders] = useState<Folder[]>([]);
  const [showCreateModal, setShowCreateModal] = useState(false);
  const [showFolderList, setShowFolderList] = useState(false);
  const [loading, setLoading] = useState(false);
  const [saving, setSaving] = useState(false);
  
  // Форма створення папки
  const [newFolder, setNewFolder] = useState({
    name: ''
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
        setNewFolder({ name: '' });
        setShowCreateModal(false);
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
        <div className="fixed inset-0 bg-black bg-opacity-30 backdrop-blur-sm flex items-center justify-center z-[10000]">
          <div className="bg-white rounded-xl shadow-xl w-full max-w-md mx-4 relative">
            {/* Заголовок */}
            <div className="px-6 py-5">
              <div className="flex items-center justify-between">
                <h2 className="text-xl font-semibold text-gray-900">
                  Створення нової папки
                </h2>
                <button
                  onClick={() => setShowCreateModal(false)}
                  className="text-gray-400 hover:text-gray-600 transition-colors"
                >
                  <X className="w-5 h-5" />
                </button>
              </div>
            </div>

            {/* Форма */}
            <div className="px-6 pb-5">
              <div className="space-y-4">
                {/* Назва папки */}
                <div>
                  <label className="block text-sm font-medium text-gray-700 mb-2">
                    Назва папки
                  </label>
                  <input
                    type="text"
                    value={newFolder.name}
                    onChange={(e) => setNewFolder(prev => ({ ...prev, name: e.target.value }))}
                    className="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent transition-colors"
                    placeholder="Введіть назву папки"
                    required
                  />
                </div>
              </div>

              {/* Кнопки */}
              <div className="flex justify-end space-x-3 mt-6">
                <button
                  type="button"
                  onClick={() => setShowCreateModal(false)}
                  className="text-gray-600 hover:text-gray-800 transition-colors font-medium"
                >
                  Скасувати
                </button>
                <button
                  type="button"
                  onClick={createFolder}
                  disabled={saving || !newFolder.name.trim()}
                  className="px-4 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700 disabled:opacity-50 disabled:cursor-not-allowed transition-colors font-medium"
                >
                  {saving ? 'Створення...' : 'Створити'}
                </button>
              </div>
            </div>
          </div>
        </div>
      )}
    </>
  );
}
