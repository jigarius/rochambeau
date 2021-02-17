# typed: strict
# frozen_string_literal: true

class Rochambeau
  class GameMode < T::Struct
    extend T::Sig

    const :options, T::Array[Option]

    private_class_method :new

    BASIC = T.let(
      new(
        options: [
          Option::ROCK,
          Option::PAPER,
          Option::SCISSORS,
        ]
      ),
      GameMode
    )

    ADVANCED = T.let(
      new(
        options: Option::ALL
      ),
      GameMode
    )
  end
end
