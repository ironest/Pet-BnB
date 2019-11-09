# Pet-BnB

## Code/Technology Requirements

**Problem Definition**

Going on holidays or arranging business travels is extremely difficult when you have pets.
Ideally, pet-owners would like to bring their furry friends with them, but pet-friendly facilities are still not too common and those who do allow pets, frequently offer ridicolously over-charged prices. The same scenarios applies to transportation; very few airline companies accept pets and, those who do, provide such service only as a luxury/premium option or by boarding animal in the cargo hold of aircrafts. On top of this, some limitations still applies to specific race/breeds (e.g. short-nosed canine breeds are normally not allowed).

As sad as it might sound, the second most logical option would be to depart without your companion and to rely on Pet Accomodations/Boarding facilities. Generally speaking, those structures claim to have highly qualified staff to look after/entertain your pet and often 24/7 on-site vets. In the best case scenario, the offered services are as good as described but they cost a fortune. In the worse case scenario, the "qualitied staff" who are supposed to keep company to your animal do their job without passion and your pet might end up being kept in small cages for the whole period.

The easist and cheapest option is to reach out to private pet-sitters, who do what they do for passion, sometimes as a hobby or a as a second job, simply because they cannot have (or cannot commit to have) a pet their self.

But how would you look for a pet sitter? Probably among your close circle of friends and family. Or also by asking them if the happen to know anyone who might be keen. Which is a very limited pool of people.

**Solution**

Here is where my project comes into play; I am creating an online web portal where pet-sitters can advertise theirself, their availability and which services they are keep to do. Pet-owners can browse those pet-sitter profiles, place a booking and eventually paying for those services.

**Live:** [pet-bnb-demo.herokuapp.com](https://pet-bnb-demo.herokuapp.com)

**Repo:** [github.com/ironest/Pet-BnB](https://github.com/ironest/Pet-BnB)

**Functionality / features**

My marketplace project allows users to:
* Register a new account
* Create their profile (firstname, lastname, profile picture)
* Create their pet's profile (name, breed, size, pet picture)
* Place bookings (in 3 phases)
  * phase 1 - expression of interest
  * phase 2 - request acceptance (or rejection)
  * phase 3 - completion (payment)
* Upgrade their profile to a Pet-sitter profile

**Sitemap**
![Sitemap](./docs/site_map.png "Diagram showing the Site Map")


**Screenshots**

<img src="./docs/screen_shot_1.png" alt="Login Page" width="200" />
<img src="./docs/screen_shot_2.png" alt="Home Page" width="200" />
<img src="./docs/screen_shot_3.png" alt="List Pets Page" width="200" />
<img src="./docs/screen_shot_4.png" alt="Show Pet Page" width="200" />
<img src="./docs/screen_shot_5.png" alt="List Petsitters Page" width="200" />
<img src="./docs/screen_shot_6.png" alt="Show Petsitter Page" width="200" />
<img src="./docs/screen_shot_7.png" alt="List Bookings Page" width="200" />

**Target audience**
The target audience for my project can be broken-down into the main categories:
* People who have pets and are looking to join a centralized place where to find petsitters.
* People who are willing to offer services such as:
  * Pet Sitting At Sitter home
  * Pet Sitting at Pet’s home
  * Pet Walking
  * Pet Grooming
  * Pet Training

**Tech stack** (e.g. html, css, deployment platform, etc)
* Frontend
  * HTML
  * CSS
  * Javascript
* Backend:
  * Ruby (version 2.6.3)
  * Rails (version 5.2.3)
  * Postgresql (version 11.5)
* Deployment platform
  * Heroku (as web-app hosting platform)
* Third party Services
  * Stripe (version 5.8)
  * Amazon S3 (as media-file storage)
* Third party Gems
  * Down (version 5.0)
  * Devise (version 4.7)

**User stories**

**Wireframes**
**Entity Relationship Diagram (ERD)**
![ERD](/docs/ERD.png)

**High-level components**
My project was build in Ruby on Rails, following an architectural pattern where the entire app is broken down into THREE high-level components:
* Models
* Views
* Controllers
Each of these components are built to handle specific development aspects of an application. MVC is one of the most frequently used industry-standard web development framework to create scalable and extensible projects.


[R16] Detail any third party services that your app will use
[R17] Describe your projects models in terms of the relationships (active record associations) they have with each other
[R18] Discuss the database relations to be implemented in your application
[R19] Provide your database schema design
[R20] Describe the way tasks are allocated and tracked in your project

* **Day 1 (Friday 25-Oct-2019)**
  * Project idea approved
  * Wireframes sketched out
  * ERD diagram designed

* **Day 2 (Monday 28-Oct-2019)** 
  * Created Models
  * Create Tables
  * Amended DB with Migrations
  * Applied Model reletionships

* **Day 3 (Tuesday 29-Oct-2019)** 
  * Installed Devise
  * Research and Experiment with Devise
  * Customization of User Model

* **Day 4 (Wednesday 30-Oct-2019)** 
  * Installed Active Storage (local)
  * Configured associations between Models and Active Storage

* **Day 5 (Thursday 31-Oct-2019)** 
  * Created Page Controller
  * Created Page (and shared) HTML & CSS

* **Day 6 (Friday 01-Nov-2019)** 
  * Entire day spent on Mobile Responsive Design 
  * Navbar design
  * Hamburger menu & Sidebar

* **Day 7 (Saturday 02-Nov-2019)** 
  * Created Pet Controller
  * Created Pet HTML & CSS
  * Researched some JS for loading images

* **Day 8 (Sunday 03-Nov-2019)** 
  * Created Petsitter Controller
  * Created Petsitter HTML & CSS

* **Day 9 (Monday 04-Nov-2019)** 
  * Modified Booking table (through migration)
  * Created Booking Controller
  * Created Booking HTML & CSS

## Presentation Requirements

[R21] An outline of the problem you were trying to solve by building this particular marketplace app, and why it’s a problem that needs solving
[R22] A walkthrough of your app