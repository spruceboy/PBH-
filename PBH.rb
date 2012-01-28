require "picasa"
require "pp"
require 'trollop'

opts = Trollop::options do
  version "JFPBGH(Jays Fancy Picasa Background Helper) v 0.0.0.0.1"
  banner <<-EOS
	This utility leaches a randomly selected photo from picasa, then invokes a background setting widget. It can also run in a demon mode, where it sets the background perodicly. 
Usage:
       JFPBGH [options] 
where [options] are:
EOS

  opt :username, "google username", :type => String
  opt :album, "picasa album name", :type => String
  opt :temp_area, "area to store images", :type => String, :default => "/tmp"
  opt :internal, "How often to fetch an new image, in minutes", :default => 3.0
  opt :iters, "Number of iterations", :default => 5
end
Trollop::die :volume, "must be non-negative" if opts[:volume] < 0
Trollop::die :file, "must exist" unless File.exist?(opts[:file]) if opts[:file]


user="spruceboy"
album_title='Moab.'


albums = Picasa.albums(:google_user => user)
id = nil
while (!id ) do
	item = albums.pop
	id = item[:id] if (item[:title] == album_title) 
end

raise ("No album called #{album_title} found.")if (id == nil)
photos = Picasa.photos(:google_user => user, :album_id => id)
pp photos.keys
puts photos[:photos][rand(photos[:photos].length() -1)][:photo]
