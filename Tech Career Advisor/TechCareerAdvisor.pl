:- dynamic user_interest/1, user_skill/1, has_certification/1.

% Career Paths Based on Interest and Skills
career_path(web_development, html_css_javascript, 'Software Developer or Frontend Developer').
career_path(data_science, python, 'Data Scientist or Data Analyst').
career_path(cybersecurity, networking, 'Cybersecurity Specialist').
career_path(cloud_computing, aws_azure_gcp, 'Cloud Engineer or Cloud Architect').
career_path(game_development, unity, 'Game Developer').
career_path(graphic_design_or_content_creation, figma, 'UI/UX Designer').
career_path(object_oriented_programming, java, 'Software Engineer or Backend Developer').
career_path(application_development, kotlin, 'Mobile Application Developer').
career_path(business_management, data_analysis, 'Business Analyst').
career_path(database_management, sql, 'Database Administrator').
career_path(testing, jira, 'Quality Assurance Engineer').
career_path(internet_of_things, c, 'Embedded Systems Engineer').

% Recommended Skills for Interests
recommended_skills(web_development, 'HTML, CSS, JavaScript').
recommended_skills(data_science, 'Python, R, Statistics').
recommended_skills(cybersecurity, 'Networking, Ethical Hacking').
recommended_skills(cloud_computing, 'AWS, Azure, Google Cloud').
recommended_skills(game_development, 'Unity, Unreal Engine').
recommended_skills(graphic_design_or_content_creation, 'Figma, Canva, Adobe Illustrator').
recommended_skills(object_oriented_programming, 'Java').
recommended_skills(application_development, 'Kotlin').
recommended_skills(business_management, 'Data Analysis').
recommended_skills(database_management, 'SQL').
recommended_skills(testing, 'Jira').
recommended_skills(internet_of_things, 'C').

% Alternate Careers Based on Skills
skill_alternate_career(html_css_javascript, 'Frontend Development or Web Design').
skill_alternate_career(python, 'Data Analysis, Backend Development, or Automation').
skill_alternate_career(networking, 'IT Support, Network Administration').
skill_alternate_career(unity, 'Game Testing or Virtual Reality Development').
skill_alternate_career(tensorflow, 'AI Operations or Data Science').
skill_alternate_career(figma, 'UI/UX Designing').
skill_alternate_career(java, 'Software Engineer, Backend Developer').
skill_alternate_career(kotlin, 'Mobile Application Developer').
skill_alternate_career(data_analysis, 'Business Analyst').
skill_alternate_career(sql, 'Database Administrator').
skill_alternate_career(jira, 'Quality Assurance Engineer').
skill_alternate_career(c, 'Embedded Systems Engineer').
skill_alternate_career(aws_azure_gcp, 'Cloud Support Engineer or DevOps Engineer').

% Entry point
career_start :-
    nl, write('=== Welcome To Tech Career Advisor ==='), nl,
    write('What is your name? '), read(Name),
    write('Hello, '), write(Name), write('!'), nl,

    % Interactive Selection
    display_menu,
    display_skills,

    % Certification Input (case-insensitive)
    write('Do you hold a certification in your area of interest? (yes/no) '), nl,
    read_downcase(CertInput),
    (CertInput == yes -> Cert = true ; Cert = false), assertz(has_certification(Cert)),

    % Evaluation
    write('Evaluating your career options...'), nl, suggest_career,
    show_summary,

    (\+ has_certification(true) ->
        write('Tip: Consider obtaining certifications in your area of interest to strengthen your profile.'), nl
    ; true),

    repeat_query.

% Convert Input to Lowercase
read_downcase(Input) :- read(UserInput), downcase_atom(UserInput, Input).

% Interest Selection
display_menu :-
    nl, write('Select your area of interest:'), nl,
    write('1. Web Development'), nl,
    write('2. Data Science'), nl,
    write('3. Cybersecurity'), nl,
    write('4. Cloud Computing'), nl,
    write('5. Game Development'), nl,
    write('6. Graphic Design or Content Creation'), nl,
    write('7. Object-Oriented Programming'), nl,
    write('8. Application Development'), nl,
    write('9. Business Management'), nl,
    write('10. Database Management'), nl,
    write('11. Testing'), nl,
    write('12. Internet of Things'), nl,
    write('Enter the corresponding number: '), read(Choice),
    map_interest_choice(Choice).

map_interest_choice(Choice) :-
    retractall(user_interest(_)),
    (Choice == 1 -> assertz(user_interest(web_development));
     Choice == 2 -> assertz(user_interest(data_science));
     Choice == 3 -> assertz(user_interest(cybersecurity));
     Choice == 4 -> assertz(user_interest(cloud_computing));
     Choice == 5 -> assertz(user_interest(game_development));
     Choice == 6 -> assertz(user_interest(graphic_design_or_content_creation));
     Choice == 7 -> assertz(user_interest(object_oriented_programming));
     Choice == 8 -> assertz(user_interest(application_development));
     Choice == 9 -> assertz(user_interest(business_management));
     Choice == 10 -> assertz(user_interest(database_management));
     Choice == 11 -> assertz(user_interest(testing));
     Choice == 12 -> assertz(user_interest(internet_of_things));
     write('Invalid choice, please try again.'), nl, display_menu).

% Skill Selection
display_skills :-
    nl, write('Select your key skill:'), nl,
    write('1. HTML, CSS, JavaScript (Web Development)'), nl,
    write('2. Python (Data Science, Automation)'), nl,
    write('3. Networking (Cybersecurity)'), nl,
    write('4. Unity (Game Development)'), nl,
    write('5. TensorFlow (AI/ML)'), nl,
    write('6. Figma (Graphic Design & Content Creation)'), nl,
    write('7. Java (OOP & Backend)'), nl,
    write('8. Kotlin (Mobile App Dev)'), nl,
    write('9. Data Analysis (Business Intelligence)'), nl,
    write('10. SQL (Database)'), nl,
    write('11. Jira (Testing & QA)'), nl,
    write('12. C (IoT & Embedded)'), nl,
    write('13. AWS, Azure, Google Cloud (Cloud Computing)'), nl,
    write('Enter the corresponding number: '), read(Choice),
    map_skill_choice(Choice).

map_skill_choice(Choice) :-
    retractall(user_skill(_)),
    (Choice == 1 -> assertz(user_skill(html_css_javascript));
     Choice == 2 -> assertz(user_skill(python));
     Choice == 3 -> assertz(user_skill(networking));
     Choice == 4 -> assertz(user_skill(unity));
     Choice == 5 -> assertz(user_skill(tensorflow));
     Choice == 6 -> assertz(user_skill(figma));
     Choice == 7 -> assertz(user_skill(java));
     Choice == 8 -> assertz(user_skill(kotlin));
     Choice == 9 -> assertz(user_skill(data_analysis));
     Choice == 10 -> assertz(user_skill(sql));
     Choice == 11 -> assertz(user_skill(jira));
     Choice == 12 -> assertz(user_skill(c));
     Choice == 13 -> assertz(user_skill(aws_azure_gcp));
     write('Invalid choice, please try again.'), nl, display_skills).

% Suggest Career
suggest_career :-
    user_interest(Interest), user_skill(Skill),
    write('Your selected interest: '), write(Interest), nl,
    write('Your current skill: '), write(Skill), nl,
    (career_path(Interest, Skill, Career) ->
        write('You are suited for a career as a '), write(Career), nl
    ; mismatch_recommendation(Interest), alternate_career(Skill)).

% Recommend Based on Interest
mismatch_recommendation(Interest) :-
    recommended_skills(Interest, Skills),
    write('Your skills don\'t match your interest: '), write(Interest), nl,
    write('Consider learning skills like: '), write(Skills), nl.

% Recommend Alternate Based on Skill
alternate_career(Skill) :-
    (skill_alternate_career(Skill, Career) ->
        write('Your current skill ('), write(Skill), write(') can be used for: '), write(Career), nl
    ; write('No direct match found for your skill, consider exploring related fields.'), nl).

% Summary Display
show_summary :-
    nl, write('=== Career Advisor Summary ==='), nl,
    user_interest(Interest),
    user_skill(Skill),
    (has_certification(true) -> CertStatus = 'Yes' ; CertStatus = 'No'),
    write('Interest Area: '), write(Interest), nl,
    write('Key Skill: '), write(Skill), nl,
    write('Certification: '), write(CertStatus), nl.

% Repeat
repeat_query :-
    write('Do you want to check another career option? (yes/no) '), nl,
    read_downcase(Response),
    (Response == yes -> career_start ; write('Thank you for using Tech Career Advisor! Good luck!'), nl).
