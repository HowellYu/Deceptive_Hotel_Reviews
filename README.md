# Deceptive_Hotel_Reviews
This study project is a repeat of work performed at Cornell University by Myle Ott, Yejin Choi, Claire Cardie and Jeffrey T. Hancock. 
Their paper Finding Deceptive Opinion Spam by Any Stretch of the Imagination details their methodology:
    http://myleott.com/op_spamACL2011.pdf

They collected, as a result of their methodology, 1600 reviews, of which 800 were deceptive, and 800 were truthful (i.e. written by an actual hotel guest). The deceptive reviews were created under contract with human workers, who were given a minute to write the review, had to live in the US, etc. 400 of each set of reviews were positive, and 400 were negative, leading to the dataset being examined:

400 truthful, positive reviews from TripAdvisor<br/>
400 deceptive positive reviews from Mechanical Turk<br/>
400 truthful, negative reviews from Expedia, Hotels.com, Orbitz, Priceline, TripAdvisor, and Yelp<br/>
400 deceptive negative reviews from Mechanical Turk<br/><br/>
This project will use a Support Vector Machine (an SVM) which is a fancy way of saying this project will calculate a place in the data where it can cleave spam from non-spam. In mathematical terms, we will calculate a hyperplane through a hyperspace defined by dimensions such as word counts, and parts-of-speech counts (nouns, adjective, etc.)
