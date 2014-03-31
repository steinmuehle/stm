  require 'susy'

  ###
  # Page options, layouts, aliases and proxies
  ###

  # Per-page layout changes:
  #
  # With no layout
  # page "/path/to/file.html", :layout => false
  #
  # With alternative layout
  # page "/path/to/file.html", :layout => :otherlayout
  #
  # A path which all have the same layout
  # with_layout :admin do
  #   page "/admin/*"
  # end

  # Proxy pages (http://middlemanapp.com/dynamic-pages/)
  # proxy "/this-page-has-no-template.html", "/template-file.html", :locals => {
  #  :which_fake_page => "Rendering a fake page with a local variable" }

  ###
  # Helpers
  ###

  # Automatic image dimensions on image_tag helper
  # activate :automatic_image_sizes

  # Reload the browser automatically whenever files change
  activate :livereload
  activate :gzip

  activate :bower
  activate :autoprefixer

  set :slim, pretty: true

  # default directories
  #set :js_dir, 'javascripts'
  #set :css_dir, 'stylesheets'
  #set :images_dir, 'images'

  # Add bower's directory to sprockets asset path
  #after_configuration do
    #@bower_config = JSON.parse(IO.read("#{root}/.bowerrc"))
    #sprockets.append_path File.join "#{root}", @bower_config["directory"]
  #end

  #after_configuration do
    #@bower_config = JSON.parse(IO.read("#{root}/.bowerrc"))
    #@bower_assets_path = File.join "#{root}", @bower_config["directory"]
    #sprockets.append_path @bower_assets_path
    ##sprockets.append_path 'vendor/assets/assets/leaflet-dist'
  #end

  after_configuration do
    @bower_config = JSON.parse(IO.read("#{root}/.bowerrc"))
    Dir.glob(File.join("#{root}", @bower_config["directory"], "*", "fonts")) do |f|
      sprockets.append_path f
    end
    sprockets.append_path File.join "#{root}", @bower_config["directory"]
  end
  # Methods defined in the helpers block are available in templates
  # helpers do
  #   def some_helper
  #     "Helping"
  #   end
  # end

  activate :deploy do |deploy|
    # ...
    deploy.build_before = true # default: false
    deploy.method = :git
    # Optional Settings
    # deploy.remote   = "custom-remote" # remote name or git url, default: origin
    # deploy.branch   = "custom-branch" # default: gh-pages
    # deploy.strategy = :submodule      # commit strategy: can be :force_push or :submodule, default: :force_push
  end

  # Build-specific configuration
  configure :build do
    # For example, change the Compass output style for deployment
    # activate :minify_css

    # Minify Javascript on build
    # activate :minify_javascript

    # Enable cache buster
    # activate :asset_hash

    #Minify html
    activate :minify_html

    # Optimize images
    activate :imageoptim do |options|
      # print out skipped images
      options.verbose = false

      # Setting these to true or nil will let options determine them (recommended)
      options.nice = true
      options.threads = true

      # Image extensions to attempt to compress
      options.image_extensions = %w(.jpg .gif .svg) #%w(.png .jpg .gif .svg)

      # compressor worker options, individual optimisers can be disabled by passing
      # false instead of a hash
      options.pngcrush_options  = {:chunks => ['alla'], :fix => false, :brute => false}
      #options.pngout_options    = {:copy_chunks => false, :strategy => 0}
      options.optipng_options   = {:level => 6, :interlace => false}
      options.advpng_options    = {:level => 4}
      options.jpegoptim_options = {:strip => ['all'], :max_quality => 100}
      options.jpegtran_options  = {:copy_chunks => false, :progressive => true, :jpegrescan => true}
      options.gifsicle_options  = {:interlace => false}
      #options.svgo_options      = {}
    end


  # Use relative URLs
  # activate :relative_assets

  # Or use a different image path
  # set :http_prefix, "/Content/images/"
end
