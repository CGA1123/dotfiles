function tomato_is_running
  if command tomato running ^ /dev/null > /dev/null
    return 0
  else
    return 1
  end
end
