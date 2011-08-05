if Rails::VERSION::MAJOR < 3 
  Mime::Type.unverifiable_types << :amf if defined? Mime::Type.unverifiable_types
else 
  Mime::Type.register "application/x-amf", :amf 
end
