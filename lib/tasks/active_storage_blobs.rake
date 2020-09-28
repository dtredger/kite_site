namespace :active_storage_blobs do
  desc 'Ensures all files are mirrored'

  task mirror_all: :environment do
    ActiveStorage::Blob.all.each do |blob|
      source_mirror = if (blob.service.primary.exist? blob.key)
                        blob.service.primary
                      else
                        blob.service.mirrors.find { |m| m.exist? blob.key }
                      end

      source_mirror.open(blob.key, checksum: blob.checksum) do |file|
        blob.service.primary.upload(blob.key, file, checksum: blob.checksum) unless blob.service.primary.exist? blob.key

        blob.service.mirrors.each do |mirror|
          next if mirror == source_mirror
          mirror.upload(blob.key, file, checksum: blob.checksum) unless mirror.exist? blob.key
        end
      end

      rescue StandardError

      puts blob.key.to_s
    end

  end
end