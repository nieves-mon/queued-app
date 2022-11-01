module TasksHelper
    def task_status(task)
        if task.completed?
            {class: 'completed', text: 'Completed'}
        elsif task.due_date < Date.current
            {class: 'overdue', text: 'Overdue'}
        else
            {class: 'pending', text: "Pending"}
        end
    end
end
