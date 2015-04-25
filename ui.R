library(shiny)

#load data
##school_by_state <- read.csv("school_by_state.csv",stringsAsFactors = FALSE)
require(datasets)

# define UI with tab panels for state information, US map, and app documentation
shinyUI(navbarPage("Locating Post-Secondary Schools by State",
                   tabPanel("Information by State",
                            sidebarPanel(selectInput("state", "Choose a state:", 
                                                     choices = sort(state.name)),
                                                                                  
                                        submitButton('Submit'), 
                                        h4("Instructions"),
                                         
                                         p("Select a state within the United States.  Click the submit button and the
                                           number of schools that are eligible for Title IV federal student financial 
                                           assistance programs within that state will be displayed. Below is a map 
                                           of the selected state with the location of each school.  
                                          "),
                                        p("The US Map tab has
                                           an interactive map showing each state and the number of eligible schools in that state.
                                          The App Documentation tab has more information on Title IV and the types of loans and grants.
                                          ")
                                         
                            ),
                            
                            mainPanel(
                              h4("Selected State:"),
                              verbatimTextOutput("Text1"),
                              h4("Number of Title IV eligible schools in the selected state:"),
                              verbatimTextOutput("Text2"),
                              h4("Locations of schools within your selected state:"), 
                              htmlOutput("myStateMap")
                            )
                   ),
                   
                   tabPanel("US Map",
                            sidebarPanel(
                              h4("Interactive map of states showing the number of schools:"),
                              p("Hover over a state, and the information will show the name of the state
                                 along with the number of Title IV eligible schools.", 
                                style = "font-family: 'baskerville'; font-si16pt"),
                              p("Colors bands go from light to dark where dark is a higher number of schools per state.", 
                                style = "font-family: 'baskerville'; font-si16pt"),
                              p("Note: the map may take a few seconds to load.", 
                                style = "font-family: 'baskerville'; font-si16pt")
                            ),
                            mainPanel(
                              h3("The map is below:"), 
                              htmlOutput("myMap")
                            )
                   ),
                   tabPanel("App Documentation",
                            mainPanel(
                              h3("App Documentation"), 
                              p("Continuing your education after high-school is a terrific objective for a student. 
                                 Determining which college to attend is difficult. The Department of Education provides
                                 access to enourmous amount of data, tools, and guidance to assist with the selection.
                                 The data used for this app is available from the Department of Education.
                                 The data allows you to explore the location of post-secondary schools that are allowed
                                 to participate in any of the Title IV federal student financial assistance programs.
                                 This app gives you three ways to look at the data.  First, by allowing you to 
                                 select a state and providing you with the number of schools in that state that qualify
                                 for Title IV.  Second, for the selected state, it shows their location and allows you 
                                 manipulate the map, and hover over the markers to get the school name.  Third,
                                 in the US Map tab that shows you the states with the least and most schools by
                                 color gradient.  Here you can hover over each state and get the number of schools
                                 in that state."),
                              p("Title IV refers to Title IV of the Higher Education Act of 1965.  The financial aid  
                                 programs authorized under Title IV are a major source of federal student aid. Title IV programs include:  
                                Loans such as Federal Family Education Loan, Direct Loan,
                                 and Federal Perkins Loan.  Grants include Federal Pell Grant, Academic
                                 Competitiveness Grant, National SMART Grant, Federal Supplemental Educational
                                 Opportunity Grant, Federal Work-Study."),
                              p("The specific file is available at the link below:"),
                              a(href = "http://inventory.data.gov/dataset/032e19b4-5a90-41dc-83ff-6e4cd234f565/resource/38625c3d-5388-4c16-a30f-d105432553a4/download/postscndryunivsrvy2013dirinfo.csv",
                                "Link to Department of Education school data at inventory.data.gov"),
                              p("Source code files for the app are located here:"),
                              a(href = "http://github.com/ShelleyStall/DataProd_ShinyApp",
                                "Link to source code on GitHub")
                                                          ))
))
