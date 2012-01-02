require 'RMagick'
include Magick

class WallDupeFinder

  IMAGE_TYPES = ['.gif', '.jpg', '.jpeg', '.png']

  def find_dupes(directory = ".")
    # Get all Images
    # Hash All Images
    # Crawl for Dupes
    # Report Dupes
    []
  end

  # Returns an array of ImageLists of images from files in given directory
  def get_images(target, path = ".")
    if File.file?(target)
      # Avoid non image files
      (IMAGE_TYPES.include?(File.extname(target.downcase)) ? [File.join(path, target)] : [])
    else
      Dir.entries(target).map do |entry|
        # Avoid hidden folders, `.`, and `..`
        (entry[0] != "." ? get_images(entry, File.join(path, target)) : [])
      end.flatten
    end
  end

  # Returns an array of image hashes of images from given array
  def hash_images(images)
    []
  end

  # Returns an array of duplicate pairs(arrays) of hashes
  def extract_dupes(hashes)
    []
  end

  # Outputs the pairs in the given dupes array in the format...
  # (a,b),(c,d)....
  def report_dupes(dupes)
  end
end
