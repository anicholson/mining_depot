# encoding: utf-8

module MiningDepot
  class Universe
    DEFAULT = 'default'

    def self.worlds
      @worlds ||= {}
    end

    def self.[](name = DEFAULT)
      worlds[name]
    end

    def self.[]=(name, world)
      worlds[name] = world
    end

    def self.reset!
      # FIXME: this should :stop all `World`s before clearing,
      # otherwise there will be resource leaks. (andrewn, 4/8/14)
      @worlds = {}
    end
  end
end
