require "shrine"
require "shrine/storage/file_system"

Shrine.storages = {
    cache: Shrine::Storage::FileSystem.new("public", prefix: "uploads/cache"), # temporary
    store: Shrine::Storage::FileSystem.new("public", prefix: "uploads/store"), # permanent
    avatar: Shrine::Storage::FileSystem.new("public", prefix: "uploads/avatars"), # permanent
    cover: Shrine::Storage::FileSystem.new("public", prefix: "uploads/covers"), # permanent
}

Shrine.plugin :cached_attachment_data