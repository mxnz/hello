class TestMarket

  def get_photo
    @photo.dup
  end

  def create_todo
    @todo_id
  end

  def set_photo(photo)
    @photo = photo
    self
  end

  def set_todo_id(id)
    @todo_id = id
    self
  end
end
