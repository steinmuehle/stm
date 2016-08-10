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

  # Methods defined in the helpers block are available in templates
  helpers do
  end


  # Automatic image dimensions on image_tag helper
  activate :automatic_image_sizes

  # Reload the browser automatically whenever files change
  activate :livereload
  activate :gzip

  activate :bower
  activate :autoprefixer

  activate :directory_indexes

  require 'slim' # Might be not needed
  set :slim, pretty: true

  require 'redcarpet'
  set :markdown_engine, :redcarpet
  set :markdown, :fenced_code_blocks => true, :smartypants => true, :hard_wrap => true, :highlight => true, :tables => true


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
     activate :minify_css

    # Minify Javascript on build
     activate :minify_javascript

    # Enable cache buster
     activate :asset_hash

    #Minify html
    activate :minify_html

    # Optimize images
  activate :imageoptim do |options|
    # Use a build manifest to prevent re-compressing images between builds
    options.manifest = false

    # Silence problematic image_optim workers
    options.skip_missing_workers = true

    # Cause image_optim to be in shouty-mode
    options.verbose = false

    # Setting these to true or nil will let options determine them (recommended)
    options.nice = true
    options.threads = true

    # Image extensions to attempt to compress
    options.image_extensions = %w(.png .jpg .gif .svg)

    # Compressor worker options, individual optimisers can be disabled by passing
    # false instead of a hash
    options.advpng    = { :level => 4 }
    options.gifsicle  = { :interlace => false }
    options.jpegoptim = { :strip => ['all'], :max_quality => 100 }
    options.jpegtran  = { :copy_chunks => false, :progressive => true, :jpegrescan => true }
    options.optipng   = { :level => 6, :interlace => false }
    options.pngcrush  = { :chunks => ['alla'], :fix => false, :brute => false }
    options.pngout    = { :copy_chunks => false, :strategy => 0 }
    options.svgo      = {}
  end


  # Use relative URLs
  # activate :relative_assets

  # Or use a different image path
  # set :http_prefix, "/Content/images/"
end




  # The following is just for reference. http://sunaku.github.io/slim-tilt-redcarpet.html
  # Setup for Redcarpet and Slim
  #require 'slim'
  #require 'tilt'
  #require 'redcarpet'
  #renderer_class = Redcarpet::Render::HTML
  #render_options = {
    ## https://github.com/vmg/redcarpet#darling-i-packed-you-a-couple-renderers-for-lunch
    #:filter_html     => false,
    #:no_images       => false,
    #:no_links        => false,
    #:no_styles       => false,
    #:safe_links_only => false,
    #:with_toc_data   => false,
    #:hard_wrap       => true,
    #:xhtml           => false,
    #:prettify        => false,
    #:link_attributes => {},
  #}
  #renderer = renderer_class.new(render_options)


  #markdown_extensions = {
    ## https://github.com/vmg/redcarpet#and-its-like-really-simple-to-use
    #:no_intra_emphasis            => false,
    #:tables                       => false,
    #:fenced_code_blocks           => false,
    #:autolink                     => false,
    #:disable_indented_code_blocks => false,
    #:strikethrough                => false,
    #:lax_spacing                  => false,
    #:space_after_headers          => false,
    #:superscript                  => false,
    #:underline                    => false,
    #:highlight                    => true,
    #:quote                        => false,
    #:footnotes                    => false,
    #:renderer                     => renderer
  #}

  ## https://github.com/slim-template/slim/issues/245#issuecomment-8833818
  #Slim::Embedded.set_default_options :markdown => markdown_extensions
  #Tilt.register Tilt::RedcarpetTemplate::Redcarpet2, 'markdown', 'mkd', 'md'
  #Tilt.prefer Tilt::RedcarpetTemplate::Redcarpet2, 'markdown'
