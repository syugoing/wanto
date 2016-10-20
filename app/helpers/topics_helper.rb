module TopicsHelper
  def choose_new_or_edit
    if action_name == 'new'
      topics_path
    elsif action_name == 'edit'
      topic_path
    end
  end

  def send_img(topic)
    return image_tag(topic.picture, alt: topic.user.name )
  end
end
