require 'social_stream/base/thinking-sphinx'

ThinkingSphinx::ActiveRecord::Interpreter.send :include, SocialStream::Base::ThinkingSphinx::ActiveRecord::Interpreter

Rails::Engine::Configuration.class_eval do
  def paths_with_indices
    @paths ||= begin
      paths = paths_without_indices
      paths.add "app/indices", eager_load: true
      paths
    end
  end

  alias_method_chain :paths, :indices
end

ThinkingSphinx::Configuration.class_eval do
  def initialize_with_paths
    initialize_without_paths

    Rails::Engine::Railties.engines.map{ |e|
      e_paths = e.paths['app/indices'].existent

      if e_paths.present?
        @index_paths = e_paths + @index_paths
      end
    }
  end

  alias_method_chain :initialize, :paths
end
