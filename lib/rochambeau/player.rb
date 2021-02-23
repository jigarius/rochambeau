# typed: ignore
# frozen_string_literal: true

module Rochambeau
  module Player
    extend(T::Sig)
    extend(T::Helpers)

    interface!

    sig { abstract.returns(String) }
    def name; end

    sig { abstract.params(options: T::Array[Option]).returns(Option) }
    def choose_option(options); end

    sig { abstract.returns(String) }
    def victory_message; end

    sig { params(message: String, options: T::Array[Option]).returns(Option) }
    def input_choice(message, options)
      shell = Thor::Shell::Basic.new
      chosen_initial = shell.ask(message, limited_to: options.map(&:initial))
      Rochambeau::Option.from_initial(chosen_initial)
    end
    protected_instance_methods(:input_choice)

    class Robot
      extend(T::Sig)
      include(Player)

      DEFAULT_NAME = 'Bot'

      sig { void }
      def initialize
        @name = T.let(DEFAULT_NAME, String)
      end

      sig { override.returns(String) }
      def name
        @name
      end

      sig { override.params(options: T::Array[Option]).returns(Option) }
      def choose_option(options)
        T.cast(options.sample, Option)
      end

      sig { override.returns(String) }
      def victory_message
        "#{@name} wins."
      end
    end

    class UnnamedHuman
      extend(T::Sig)
      include(Player)

      sig { override.returns(String) }
      def name
        'You'
      end

      sig { override.params(options: T::Array[Option]).returns(Option) }
      def choose_option(options)
        input_choice('Make a choice', options)
      end

      sig { override.returns(String) }
      def victory_message
        'You win!'
      end
    end

    class NamedHuman
      extend(T::Sig)
      include(Player)

      sig { params(name: String).void }
      def initialize(name)
        @name = T.let(name, String)
      end

      sig { override.returns(String) }
      def name
        @name
      end

      sig { override.params(options: T::Array[Option]).returns(Option) }
      def choose_option(options)
        input_choice("#{@name}, choose", options)
      end

      sig { override.returns(String) }
      def victory_message
        "#{@name} wins."
      end
    end
  end
end
