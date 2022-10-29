module CategoriesHelper
    def get_status(category)
      tasks = category.tasks

      if tasks.where(due_date: ..Date.current, completed: false || nil).any?
        {class: 'overdue', text: 'MAYDAY!!!'}
      elsif tasks.where(completed: false || nil).any?
        {class: 'pending', text: 'Still got some work to do'}
      else
        {class: 'finished', text: "You're all good here :D"}
      end
    end
end
