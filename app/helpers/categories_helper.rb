module CategoriesHelper
    def category_status(category)
      tasks = category.tasks

      if tasks.where(due_date: ...Date.current, completed: false).any?
        {class: 'overdue', text: 'MAYDAY!!!'}
      elsif tasks.where(completed: false).any?
        {class: 'pending', text: 'Still got some work to do'}
      else
        {class: 'completed', text: "You're all good here :D"}
      end
    end
end
