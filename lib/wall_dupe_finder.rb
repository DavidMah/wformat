require 'RMagick'
include Magick

class WallDupeFinder

  def find_dupes(directory = ".")
    # Get all Images
    # Hash All Images
    # Crawl for Dupes
    # Report Dupes
    []
  end

  # Returns an array of ImageLists of images from files in given directory
  def get_images(directory)
    []
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
