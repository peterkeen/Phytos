class Photo < ActiveRecord::Base
  attr_accessible :description, :name, :photo, :photo_cache

  def submit_to_blitline
    job = Blitline::Job.new(self.photo.url)
    job.application_id = ENV['BLITLINE_APP_ID']

    large = job.add_function("resize_to_fit", {:width => 1024, :height => 768})
    large.add_save("large", versionize_path(self.photo.file.path, :large), "bugsplat-photos")

    medium = large.add_function("resize_to_fit", {:width => 800, :height => 600})
    medium.add_save("medium", versionize_path(self.photo.file.path, :medium), "bugsplat-photos")

    small = medium.add_function("resize_to_fit", {:width => 240, :height => 180})
    small.add_save("small", versionize_path(self.photo.file.path, :small), "bugsplat-photos")

    thumb = small.add_function("resize_to_fill", {:width => 100, :height => 100})
    thumb.add_save("thumb", versionize_path(self.photo.file.path, :thumb), "bugsplat-photos")

    service = Blitline.new
    service.jobs << job
    service.post_jobs

    self.status = :processing
  end

  mount_uploader :photo, PhotoUploader

  def versionize_path(path, version)
    dirname = File.dirname(path)
    basename = File.basename(path)
    "#{dirname}/#{version.to_s}_#{basename}"
  end

end
