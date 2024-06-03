# Seed file for mental health tracking application

# Create default users
User.create(email: 'user1@example.com', password: 'password', password_confirmation: 'password')
User.create(email: 'user2@example.com', password: 'password', password_confirmation: 'password')

# Create some tips
Tip.create(content: 'Stay active with regular exercise to maintain physical and mental health.')
Tip.create(content: 'Eat a balanced diet to support overall well-being.')
Tip.create(content: 'Ensure you get enough sleep to rejuvenate your body and mind.')

# Create some exercises
Exercise.create(name: 'Meditation', description: 'Spend 10 minutes a day meditating to clear your mind.')
Exercise.create(name: 'Breathing Exercises', description: 'Practice deep breathing exercises to reduce stress.')
Exercise.create(name: 'Yoga', description: 'Perform yoga exercises to enhance flexibility and mental clarity.')

# Create some professionals
Professional.create(name: 'Dr. Jane Doe', description: 'Licensed psychologist with 10 years of experience.', contact_info: 'jane.doe@example.com')
Professional.create(name: 'Dr. John Smith', description: 'Expert in cognitive behavioral therapy.', contact_info: 'john.smith@example.com')

# Create some journal entries for the first user
user1 = User.find_by(email: 'user1@example.com')
user1.journal_entries.create(content: 'Today I felt very productive and happy.', date: Date.today)
user1.journal_entries.create(content: 'Feeling a bit anxious about the upcoming project.', date: Date.yesterday)

# Create some journal entries for the second user
user2 = User.find_by(email: 'user2@example.com')
user2.journal_entries.create(content: 'Had a relaxing day at the beach.', date: Date.today)
user2.journal_entries.create(content: 'Feeling stressed about work.', date: Date.yesterday)
