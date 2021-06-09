function tomato_is_up
  if command tomato up ^ /dev/null > /dev/null
    return 0
  else
    return 1
  end
end
