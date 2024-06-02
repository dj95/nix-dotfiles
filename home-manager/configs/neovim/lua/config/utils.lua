-- helper function for checking if an array contains a value
local function has_value (tab, val)
  for _, value in ipairs(tab) do
    if value == val then
      return true
    end
  end

  return false
end


-- export the functions
return {
    has_value = has_value
}
