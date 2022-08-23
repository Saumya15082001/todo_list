defmodule TodoList do
  def create_list do
    {tasks,_q} = IO.gets("Enter the number of tasks: ") |> Integer.parse()
    for _ <- 1..tasks do
      IO.gets("Enter your task: ") |> String.trim()
    end

  end

  def temp_list do
    ["Exercise","Eat","Code","Sleep"]
  end

  #Add tasks in the list
  def add_task(taskList, task) do
    List.insert_at(taskList,-1,task)
  end

  #Removes tasks from the list which are completed.
  def complete_task(taskList, task) do
    if contains?(taskList, task) do
      List.delete(taskList,task)
    else
      :Task_notFound
    end
  end

  #Checks if the given taskList contains a particular task
  def contains?(taskList,task) do
    Enum.member?(taskList,task)
  end

  #Randomly selects any task from the given list
  def random_select(taskList) do
    [task]= Enum.take_random(taskList,1)
    task
  end

  #Search for a particular keyword in a task
  def keyword_search(taskList,word) do
    for task <- taskList, String.contains?(task, word) do
      task
    end
  end

  #Saving our Task List in a file
  def save(taskList, filename) do
    #for this, we need to convert our list into a form that can be wriiten in our file system
    binary = :erlang.term_to_binary(taskList)
    File.write(filename, binary)
  end

  #Reading our saved TaskList
  def read(filename) do
    case File.read(filename) do
      {:ok, binary} -> :erlang.binary_to_term(binary)
      {:error, _ } -> "File does not exist"
    end
  end
end
