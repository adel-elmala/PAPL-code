people=table: name,age
  row: "adel", 23
  row: "ali" , 99
end

email = table: sender, recipient, subject
  row: 'Matthias Felleisen', 'Pedro Diaz', 'Introduction'
  row: 'Joe Politz', 'Pedro Diaz', 'Class on Friday'
  row: 'Matthias Felleisen', 'Pedro Diaz', 'Book comments'
  row: 'Mia Minnes', 'Pedro Diaz', 'CSE8A Midterm'
  row: 'Matthias Felleisen', 'Pedro Diaz', 'Book comments1'
  row: 'Matthias Felleisen', 'Pedro Diaz', 'Book comments2'
  row: 'Matthias Felleisen', 'Pedro Diaz', 'Book comments3'
  row: 'Matthias Felleisen', 'Pedro Diaz', 'Book comments4'
  row: 'Matthias Felleisen', 'Pedro Diaz', 'Book comments5'
  row: 'Matthias Felleisen', 'Pedro Diaz', 'Book comments6'
end


selcted-emails = sieve email using sender:
  sender == "Matthias Felleisen"
end

order selcted-emails:
  subject ascending
end


extended = extend email using subject:
  subject-length: string-length(subject)
end

ord = order extended:
  subject-length ascending
end

sieve ord using subject-length:
  subject-length > 13
end
select sender ,subject-length from ord end