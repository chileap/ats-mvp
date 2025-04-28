# Clear existing data
Application::Event.destroy_all
Application.destroy_all
Candidate.destroy_all
Job::Event.destroy_all
Job.destroy_all

# Create jobs with different activation scenarios

# Case 1: Job that is currently activated (never deactivated)
job1 = Job.create!(title: 'Senior Developer', description: 'Looking for experienced developer')
job1.events.create!(type: 'Job::Event::Activated', created_at: 1.day.ago)

# Case 2: Job that was activated, then deactivated
job2 = Job.create!(title: 'Product Manager', description: 'Product management role')
job2.events.create!(type: 'Job::Event::Activated', created_at: 3.days.ago)
job2.events.create!(type: 'Job::Event::Deactivated', created_at: 2.days.ago)

# Case 3: Job that was activated, deactivated, then activated again (currently activated)
job3 = Job.create!(title: 'UX Designer', description: 'User experience design role')
job3.events.create!(type: 'Job::Event::Activated', created_at: 5.days.ago)
job3.events.create!(type: 'Job::Event::Deactivated', created_at: 4.days.ago)
job3.events.create!(type: 'Job::Event::Activated', created_at: 3.days.ago)

# Case 4: Job that was never activated
job4 = Job.create!(title: 'Marketing Specialist', description: 'Marketing role')

# Case 5: Job that was activated, deactivated, then activated again, then deactivated (currently deactivated)
job5 = Job.create!(title: 'Data Analyst', description: 'Data analysis role')
job5.events.create!(type: 'Job::Event::Activated', created_at: 6.days.ago)
job5.events.create!(type: 'Job::Event::Deactivated', created_at: 5.days.ago)

# Create candidates
candidate1 = Candidate.create!(
  name: 'John Doe',
  email: 'john@example.com'
)

candidate2 = Candidate.create!(
  name: 'Jane Smith',
  email: 'jane@example.com'
)

candidate3 = Candidate.create!(
  name: 'Bob Johnson',
  email: 'bob@example.com'
)

# Create applications with different status scenarios

# Case 1: Application that is just applied (no events)
app1 = Application.create!(
  job: job1,
  candidate: candidate1
)

# Case 2: Application that is in interview stage
app2 = Application.create!(
  job: job1,
  candidate: candidate2
)
app2.events.create!(
  type: 'Application::Event::Interview',
  interview_date: 2.days.ago
)

# Case 3: Application that was interviewed and hired
app3 = Application.create!(
  job: job3,
  candidate: candidate3
)
app3.events.create!(
  type: 'Application::Event::Interview',
  interview_date: 4.days.ago
)
app3.events.create!(
  type: 'Application::Event::Hired',
  hired_at: 3.days.ago
)

# Case 4: Application that was interviewed and rejected
app4 = Application.create!(
  job: job3,
  candidate: candidate1
)
app4.events.create!(
  type: 'Application::Event::Interview',
  interview_date: 5.days.ago
)
app4.events.create!(
  type: 'Application::Event::Rejected'
)

# Case 5: Application with notes
app5 = Application.create!(
  job: job1,
  candidate: candidate3
)
app5.events.create!(
  type: 'Application::Event::Note',
  content: 'Candidate has relevant experience'
)
app5.events.create!(
  type: 'Application::Event::Interview',
  interview_date: 1.day.ago
)
app5.events.create!(
  type: 'Application::Event::Note',
  content: 'Interview went well'
)

puts "Created #{Job.count} jobs with various activation states"
puts "Created #{Candidate.count} candidates"
puts "Created #{Application.count} applications"
puts "Currently activated jobs: #{Job.activated.count}"
