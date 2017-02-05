defmodule Cards do
  @moduledoc """
    Provides methods for creating and handling a deck of cards
  """

  @doc """
    Returns a list of strings representing a deck of playing cards.
  """
  def create_deck do
    values = ["Ace", "Two", "Three", "Four", "Five", "Six", "Seven"]
    suits = ["Spades", "Clubs", "Hearts", "Diamonds"]

    for suit <- suits, value <- values do
      "#{value} of #{suit}"
    end
  end

  @doc """
    Takes a deck and returns a shuffled deck.
  """
  def shuffle(deck) do
    Enum.shuffle(deck)
  end

  @doc """
    Takes a deck and a card and returns a boolean if the card can be found in the deck.
  """
  def contains?(deck, card) do
    Enum.member?(deck, card)
  end

  @doc """
    Divides a deck into a hand and the remainder of the deck.
    The `hand_size` argument indiciates how many cards should be in a hand.
    Returns a tuple.
  """
  def deal(deck, hand_size) do
    Enum.split(deck, hand_size)
  end

  @doc """
    Takes a `deck` and `filename`, saves the deck as `filename` to local storage.
  """
  def save(deck, filename) do
    binary = :erlang.term_to_binary(deck)
    File.write(filename, binary)
  end

  @doc """
    Takes a `filename` and returns the saved deck.
  """
  def load(filename) do
    case File.read(filename) do
      {:ok, binary} -> :erlang.binary_to_term(binary)
      {:error, reason} -> "That file does not exist."
    end
  end

  @doc """
    Creates a deck, shuffles cards in deck and returns tuple of `hand_size`
    and deck of remaining cards like the deal method.
  """
  def create_hand(hand_size) do
    Cards.create_deck
    |> shuffle
    |> deal(hand_size)
  end
end
