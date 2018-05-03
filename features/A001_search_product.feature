Feature: A001 - Search Video
   As An anonymous user
   I Want to search video
   So That I can find my needs

   Background: User goes to home page
      Given user goes to homepage

      @javascript @desktop @search
      Scenario: Member should see the result for "Game of Thrones"
         When member selects "Amazon Video" from search departmant
         And member searches for "Game of Thrones"
         Then member should see 'Amazon Video : "Game of Thrones"' in filter 
         And member should see the result for "Game of Thrones"

      @javascript @desktop @navigate-video
      Scenario: Member should see links in the top menu
         When member navigates to "All Videos" sub-category in "Amazon Video" from Departmants
         Then member should see the "Amazon Video" bold in head
         Then member should see the following page by clicking the link in head menu
            | Amazon Video       |
            | Originals          |
            | TV Shows           |
            | Movies             |
            | Kids               |
            | Help               |
            | Getting Started    |
            | Settings           |
            | Your Video Library |
            | Your Watchlist     |
         
