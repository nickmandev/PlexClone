require 'shrine'
require 'shrine/storage/file_system'

Shrine.storages = {
  cache: Shrine::Storage::FileSystem.new('public', prefix: 'upload/cache'),
  store: Shrine::Storage::FileSystem.new('public', prefix: 'upload/storage')
}

Shrine.plugin :activerecord