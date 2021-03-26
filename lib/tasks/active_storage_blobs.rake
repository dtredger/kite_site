# frozen_string_literal: true

namespace :active_storage_blobs do
  desc 'Ensures all files are mirrored'

  task mirror_all: :environment do
    ActiveStorage::Blob.all.each do |blob|
      # make sure all blobs created before use mirror service
      blob.update(service_name: 'mirror')
      puts "change service for #{blob.filename}"

      source_mirror = if blob.service.primary.exist? blob.key
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

    rescue StandardError => e
      puts e
      puts blob.key.to_s
    end
  end

  desc 'Remove unattached files > 2 days old'
  task purge_unattached: :environment do
    ActiveStorage::Blob.unattached.where('active_storage_blobs.created_at <= ?', 2.days.ago).find_each(&:purge_later)
  end
end

# blob  5zynlm89jtj4n5w7vn1741tr9kux
# "filename", "st-louis-1.jpg"
# ActiveStorage::VariantRecord"], ["record_id", 495], ["blob_id", 1542]
