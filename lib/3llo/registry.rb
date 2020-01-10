module Tr3llo
  class Registry
    attr_reader :counter, :store

    def initialize
      @store = {}
      @semaphore = Mutex.new()
    end

    def register(type, id)
      @semaphore.synchronize do
        data =
          @store.fetch(type, {
            counter: 0,
            id_to_shortcut: {},
            shortcut_to_id: {}
          })

        id_to_key = data[:id_to_shortcut]
        key_to_id = data[:shortcut_to_id]

        if id_to_key.key?(id)
          id_to_key.fetch(id)
        else
          counter = data[:counter] + 1
          shortcut = counter.to_s

          data[:counter] = counter
          data[:id_to_shortcut][id] = shortcut
          data[:shortcut_to_id][shortcut] = id

          @store[type] = data

          shortcut
        end
      end
    end

    def reverse_lookup(type, shortcut)
      @store.dig(type, :shortcut_to_id, shortcut)
    end
  end
end
