%{
  configs: [
    %{
      name: "default",
      files: %{
        included: ["lib/", "config/", "test/"],
        excluded: [~r"/_build/", ~r"/deps/"]
      },
      check_for_updates: true,
      checks: [
        {Credo.Check.Readability.MaxLineLength, priority: :low, max_length: 100}
      ]
    }
  ]
}
