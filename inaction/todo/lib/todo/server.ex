defmodule TodoServer do
  use GenServer

  @doc false
  def start_link do
    GenServer.start_link(__MODULE__, nil)
  end

  @doc false
  def add_entry(todo_server, new_entry) do
    GenServer.cast(todo_server, {:add_entry, new_entry})
  end

  @doc false
  def entries(todo_server, date) do
    GenServer.call(todo_server, {:entries, date})
  end

  #======================================================================#

  @doc false
  def init(_) do
    {:ok, TodoList.new}
  end

  @doc false
  def handle_cast({:add_entry, new_entry}, todo_list) do
    new_list = TodoList.add_entry(todo_list, new_entry)
    {:noreply, new_list}
  end

  @doc false
  def handle_call({:entries, date}, _from, todo_list) do
    {:reply, TodoList.entries(todo_list, date), todo_list}
  end
end
