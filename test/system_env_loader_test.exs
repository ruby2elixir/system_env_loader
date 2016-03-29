defmodule SystemEnvLoaderTest do
  use ExUnit.Case
  doctest SystemEnvLoader

  def assert_parse(s, e) do
    assert SystemEnvLoader.parse_content(s) == e
  end

  setup do
    System.delete_env("API_SIGN_SECRET")
    :ok
  end

  test "parse_content: works with OK files" do
    assert_parse ~s(#export SECRET_KEY_BASE=""),       []
    assert_parse ~s(export SECRET_KEY_BASE=""),        [{"SECRET_KEY_BASE", ""}]
    assert_parse ~s(export SECRET_KEY_BASE="a"),       [{"SECRET_KEY_BASE", "a"}]
    assert_parse ~s(export SECRET_KEY_BASE='a'),       [{"SECRET_KEY_BASE", "a"}]
    assert_parse ~s(export SECRET_KEY_BASE=a),         [{"SECRET_KEY_BASE", "a"}]


    assert_parse ~s(export A="a val"\nexport B=$A),    [{"A", "a val"}, {"B", "$A"}]

    # exceptions
    assert_parse ~s(export SECRET_KEY_BASE=""a""),     [{"SECRET_KEY_BASE", "\"a\""}]
    assert_parse ~s(export SECRET_KEY_BASE=""a""),     [{"SECRET_KEY_BASE", "\"a\""}]
    assert_parse ~s(export SECRET_KEY_BASE=),          [{"SECRET_KEY_BASE", ""}]
    assert_parse ~s(export =dfdf),                     [{"", "dfdf"}]
    assert_parse ~s(export =),                         [{"", ""}]
  end


  test "load" do
    assert System.get_env("API_SIGN_SECRET") == nil
    SystemEnvLoader.load("test/fixtures/env_ok.txt")
    assert System.get_env("API_SIGN_SECRET") == "XXX"
  end
end
