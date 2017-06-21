# README
Getting started:
1) Download this app using git. 
2)Run bundle. 
3)Run rake db:migrate. 
4)Run rails s to view locally. 
Dev Note: 1 potential problem, ruby 2.2 can sometimes give an error on the first run, moving the contents of the parent folder out and in should fix it: https://stackoverflow.com/questions/27884908/rails-abstractcontrollerhelpersmissinghelpererror-missing-helper-file-app

Reflection on project
This project I believe meets all the specificiations of your assignment. The site is cached and provides a time stamp of the latest caching event. 
The caching is configured in config/environments/development.rb
    config.cache_store = :memory_store, {expires_in: 30.minutes}
Simply change 30.minutes to a shorter time if you'd like to do a test. 
The app itself is pretty brittle, but it does prevent you from submitting anything but a 5 digit numeric, using a private regex (/\d{5}/.match(params[:zipcode])) based validation in the locations_controller.rb file and flashes a notice if you should fail.
I went ahead and made a simple forecast list, with a three hour interval. This could be configured to whatever spec the client desires.
For initial development I used a scaffold for a simple MVC with routes. 
Initially I was storing the zipcodes in the model, but I refactored that out of the project because it didn't seem like an appropriate solution for a simple API query.
I used bootstrap for the styling and a form_tag, located under /views/layouts/navigation/_sidebar.erb to perform the search. This could clearly be improved but as a proof of concept I hope you will find it acceptable. Thank you for the opportunity to interview with Blit and I look forward to hearing from you.
Regards,
Braden Mets
bradenmets@yahoo.com
9163351642
* ...
