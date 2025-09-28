'use client'

import { useState, useRef, useEffect, useCallback } from 'react'
import { Button } from '@/components/ui/button'
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card'
import { 
  Play, 
  Pause, 
  Volume2, 
  VolumeX, 
  Maximize, 
  RotateCcw,
  Settings,
  CheckCircle,
  Clock
} from 'lucide-react'

interface VideoPlayerProps {
  videoUrl: string
  topicId: string
  userId: string
  onProgressUpdate: (progress: number) => void
  onVideoComplete: () => void
  initialProgress?: number
}

export function VideoPlayer({ 
  videoUrl, 
  topicId, 
  onProgressUpdate, 
  onVideoComplete,
  initialProgress = 0 
}: VideoPlayerProps) {
  const videoRef = useRef<HTMLVideoElement>(null)
  const [isPlaying, setIsPlaying] = useState(false)
  const [currentTime, setCurrentTime] = useState(0)
  const [duration, setDuration] = useState(0)
  const [volume, setVolume] = useState(1)
  const [isMuted, setIsMuted] = useState(false)
  const [playbackRate, setPlaybackRate] = useState(1)
  const [showSettings, setShowSettings] = useState(false)
  const [progress, setProgress] = useState(initialProgress)
  const [isLoading, setIsLoading] = useState(true)

  const updateProgress = useCallback(async (newProgress: number) => {
    try {
      await fetch('/api/user/progress', {
        method: 'PUT',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({
          topic_id: topicId,
          video_progress: newProgress,
          video_completed: newProgress >= 95, // Вважаємо завершеним при 95%
        }),
      })
      onProgressUpdate(newProgress)
    } catch (error) {
      console.error('Error updating progress:', error)
    }
  }, [topicId, onProgressUpdate])

  useEffect(() => {
    const video = videoRef.current
    if (!video) return

    const handleLoadedMetadata = () => {
      setDuration(video.duration)
      setIsLoading(false)
      
      // Встановлюємо початковий час після завантаження метаданих
      if (initialProgress > 0) {
        video.currentTime = (initialProgress / 100) * video.duration
      }
    }

    const handleTimeUpdate = () => {
      const currentProgress = (video.currentTime / video.duration) * 100
      setCurrentTime(video.currentTime)
      setProgress(currentProgress)
      
      // Оновлюємо прогрес кожні 5 секунд
      if (Math.floor(video.currentTime) % 5 === 0) {
        updateProgress(currentProgress)
      }
    }

    const handleEnded = () => {
      setIsPlaying(false)
      setProgress(100)
      updateProgress(100)
      onVideoComplete()
    }

    const handlePlay = () => setIsPlaying(true)
    const handlePause = () => setIsPlaying(false)

    video.addEventListener('loadedmetadata', handleLoadedMetadata)
    video.addEventListener('timeupdate', handleTimeUpdate)
    video.addEventListener('ended', handleEnded)
    video.addEventListener('play', handlePlay)
    video.addEventListener('pause', handlePause)

    return () => {
      video.removeEventListener('loadedmetadata', handleLoadedMetadata)
      video.removeEventListener('timeupdate', handleTimeUpdate)
      video.removeEventListener('ended', handleEnded)
      video.removeEventListener('play', handlePlay)
      video.removeEventListener('pause', handlePause)
    }
  }, [duration, initialProgress, onVideoComplete, updateProgress])

  const togglePlayPause = () => {
    const video = videoRef.current
    if (!video) return

    if (isPlaying) {
      video.pause()
    } else {
      video.play()
    }
  }

  const handleSeek = (e: React.ChangeEvent<HTMLInputElement>) => {
    const video = videoRef.current
    if (!video) return

    const seekTime = (parseFloat(e.target.value) / 100) * duration
    video.currentTime = seekTime
    setCurrentTime(seekTime)
  }

  const toggleMute = () => {
    const video = videoRef.current
    if (!video) return

    video.muted = !isMuted
    setIsMuted(!isMuted)
  }

  const handleVolumeChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const video = videoRef.current
    if (!video) return

    const newVolume = parseFloat(e.target.value)
    video.volume = newVolume
    setVolume(newVolume)
    setIsMuted(newVolume === 0)
  }

  const changePlaybackRate = (rate: number) => {
    const video = videoRef.current
    if (!video) return

    video.playbackRate = rate
    setPlaybackRate(rate)
  }

  const toggleFullscreen = () => {
    const video = videoRef.current
    if (!video) return

    if (document.fullscreenElement) {
      document.exitFullscreen()
    } else {
      video.requestFullscreen()
    }
  }

  const resetProgress = () => {
    const video = videoRef.current
    if (!video) return

    video.currentTime = 0
    setCurrentTime(0)
    setProgress(0)
    updateProgress(0)
  }

  const formatTime = (time: number) => {
    const minutes = Math.floor(time / 60)
    const seconds = Math.floor(time % 60)
    return `${minutes}:${seconds.toString().padStart(2, '0')}`
  }

  if (isLoading) {
    return (
      <Card className="w-full">
        <CardContent className="p-8">
          <div className="flex items-center justify-center">
            <div className="spinner w-8 h-8"></div>
            <span className="ml-3 text-gray-600">Завантаження відео...</span>
          </div>
        </CardContent>
      </Card>
    )
  }

  return (
    <Card className="w-full">
      <CardHeader>
        <CardTitle className="flex items-center justify-between">
          <span>Відеолекція</span>
          <div className="flex items-center space-x-2">
            <span className="text-sm text-gray-500">
              {formatTime(currentTime)} / {formatTime(duration)}
            </span>
            <div className="flex items-center space-x-1">
              <Clock className="h-4 w-4 text-gray-400" />
              <span className="text-sm text-gray-500">
                {Math.round(progress)}% завершено
              </span>
            </div>
          </div>
        </CardTitle>
      </CardHeader>
      <CardContent className="space-y-4">
        {/* Video Container */}
        <div className="relative bg-black rounded-lg overflow-hidden">
          <video
            ref={videoRef}
            src={videoUrl}
            className="w-full h-auto max-h-96"
            preload="metadata"
          />
          
          {/* Video Controls Overlay */}
          <div className="absolute bottom-0 left-0 right-0 bg-gradient-to-t from-black/70 to-transparent p-4">
            {/* Progress Bar */}
            <div className="mb-3">
              <input
                type="range"
                min="0"
                max="100"
                value={progress}
                onChange={handleSeek}
                className="w-full h-2 bg-gray-600 rounded-lg appearance-none cursor-pointer slider"
                style={{
                  background: `linear-gradient(to right, #1128C6 0%, #1128C6 ${progress}%, #4B5563 ${progress}%, #4B5563 100%)`
                }}
              />
            </div>
            
            {/* Control Buttons */}
            <div className="flex items-center justify-between">
              <div className="flex items-center space-x-3">
                <Button
                  onClick={togglePlayPause}
                  size="sm"
                  className="bg-white/20 hover:bg-white/30 text-white"
                >
                  {isPlaying ? <Pause className="h-4 w-4" /> : <Play className="h-4 w-4" />}
                </Button>
                
                <Button
                  onClick={toggleMute}
                  size="sm"
                  className="bg-white/20 hover:bg-white/30 text-white"
                >
                  {isMuted ? <VolumeX className="h-4 w-4" /> : <Volume2 className="h-4 w-4" />}
                </Button>
                
                <input
                  type="range"
                  min="0"
                  max="1"
                  step="0.1"
                  value={volume}
                  onChange={handleVolumeChange}
                  className="w-20 h-1 bg-white/30 rounded-lg appearance-none cursor-pointer"
                />
                
                <Button
                  onClick={resetProgress}
                  size="sm"
                  className="bg-white/20 hover:bg-white/30 text-white"
                >
                  <RotateCcw className="h-4 w-4" />
                </Button>
              </div>
              
              <div className="flex items-center space-x-2">
                <div className="relative">
                  <Button
                    onClick={() => setShowSettings(!showSettings)}
                    size="sm"
                    className="bg-white/20 hover:bg-white/30 text-white"
                  >
                    <Settings className="h-4 w-4" />
                  </Button>
                  
                  {showSettings && (
                    <div className="absolute bottom-full right-0 mb-2 bg-white rounded-lg shadow-lg p-2 min-w-32">
                      <div className="text-xs text-gray-600 mb-2">Швидкість відтворення</div>
                      {[0.5, 0.75, 1, 1.25, 1.5, 2].map((rate) => (
                        <button
                          key={rate}
                          onClick={() => changePlaybackRate(rate)}
                          className={`block w-full text-left px-2 py-1 text-sm rounded hover:bg-gray-100 ${
                            playbackRate === rate ? 'bg-primary-100 text-primary-600' : 'text-gray-700'
                          }`}
                        >
                          {rate}x
                        </button>
                      ))}
                    </div>
                  )}
                </div>
                
                <Button
                  onClick={toggleFullscreen}
                  size="sm"
                  className="bg-white/20 hover:bg-white/30 text-white"
                >
                  <Maximize className="h-4 w-4" />
                </Button>
              </div>
            </div>
          </div>
        </div>
        
        {/* Progress Info */}
        <div className="flex items-center justify-between text-sm text-gray-600">
          <div className="flex items-center space-x-4">
            <span>Прогрес: {Math.round(progress)}%</span>
            {progress >= 95 && (
              <div className="flex items-center space-x-1 text-success-600">
                <CheckCircle className="h-4 w-4" />
                <span>Завершено</span>
              </div>
            )}
          </div>
          <span>Тривалість: {formatTime(duration)}</span>
        </div>
      </CardContent>
    </Card>
  )
}
