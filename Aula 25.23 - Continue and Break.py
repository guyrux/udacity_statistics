# HINT: modify the headlines list to verify your loop works with different inputs
headlines = ["Local Bear Eaten by Man",
             "Legislature Announces New Laws",
             "Peasant Discovers Violence Inherent in System",
             "Cat Rescues Fireman Stuck in Tree",
             "Brave Knight Runs Away",
             "Papperbok Review: Totally Triffic"]

news_ticker = ""
# write your loop here

for words in headlines:
    if len(news_ticker) == 140:
        #print(news_ticker)
        #print("Break")
        break
    if len(news_ticker) > 140:
        while len(news_ticker) > 140:
            news_ticker = news_ticker[:-1]
            #print(news_ticker)
            #print("While Break")
        #print("Break")
        break
    #elif len(news_ticker) + len(words) > 140:
        #continue
        #print("Continue")
    else:
        news_ticker += words + " "

print(news_ticker)