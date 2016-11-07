defmodule A do
  defmacro add_func do 
  quote do 
    alias B
    use GenServer
   def test do 
       IO.inspect __MODULE__
   end
  end
  end
end

defmodule B do 
  import A
  add_func
end

B.test
