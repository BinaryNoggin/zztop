# Global constants that apply to the site as a whole.
# Idea from http://www.smashingmagazine.com/2009/02/25/ruby-on-rails-tips/.

# Name (identifier) of the project. Generally the same name as the directory containing the project.
PROJECT_NAME = Rails.root.to_s.split('/').last

# Override these - they will be used in the default layout.
SITE_NAME = "Phome"
SITE_TITLE = SITE_NAME + ('production' == Rails.env ? '' : " (#{Rails.env.upcase})")

# Hostname of the site. This will be used by Clearance to generate URLs in emails, to create a CSS signature, and possibly in several other places.
# NOTE: It's highly recommended that you hard-code this.
HOST = (ENV['SERVER_NAME']||'localhost').gsub(/[^A-Za-z0-9._-]/, '') # Ensure we get a valid hostname -- see http://shiflett.org/blog/2006/mar/server-name-versus-http-host.

# Create a CSS signature (http://archivist.incutio.com/viewlist/css-discuss/13291) for pages in your site.
CSS_SIGNATURE = HOST.gsub(/[.]/, '-')

# Years and name to list in copyright statements.
COPYRIGHT_YEARS = '2008, 2009, 2010'
COPYRIGHT_OWNER = Etc.getpwuid().gecos # NOTE: This probably isn't what you want -- you should really hard-code this.

# Version of jQuery to use.
JQUERY_VERSION = '3.1.1'

# Google Analytics code. Set this to enable Google Analytics on the site.
GOOGLE_ANALYTICS_CODE = nil

# Google Webmaster Tools (http://www.google.com/webmasters/) code. Set this to verify that you control the site, so you can see how Google views your site.
GOOGLE_WEBMASTERS_CODE = nil

# Email exceptions to this list of addresses, if ExceptionNotifier is loaded.
EMAIL_EXCEPTIONS_TO = []

# Reply address for emails. Used by Clearance, and possibly other gems/plugins.
DO_NOT_REPLY = "donotreply@#{HOST}"
