module Sub
  class Engine < ::Rails::Engine
    isolate_namespace Sub
  end
end
