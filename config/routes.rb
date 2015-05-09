Rails.application.routes.draw do

  get("/",{ :controller => "pages", :action => "welcome" })

  get("/:the_calc",{ :controller => "pages", :action => "calculator" })
  get("/:the_calc/results",{ :controller => "pages", :action => "calculator_results" })



end
