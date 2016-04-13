likes(frank,Food):- italian(Food).
likes(frank,Food):- indian(Food),mild(Food).

likes(anna,Food):- indian(Food).
likes(anna,hamburger).

likes(kurt,pizza).
likes(kurt,Food):- likes(anna,Food).

italian(pizza).
italian(spaghetti).

indian(dahl).
indian(curry).

mild(dahl).
hot(curry).
