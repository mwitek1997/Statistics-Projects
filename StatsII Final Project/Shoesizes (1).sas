/*Import the given data*/
Title 'Original Data';
data shoesize;
	INFILE '/folders/myfolders/StatsII Final Project/shoesize.txt' dsd dlm='	' truncover Firstobs= 2;
	INPUT Size Height Sex $;
	
PROC PRINT data=shoesize;
	RUN;

/* A. Seperate Male and Female data into two tables.*/
Title 'Mens Data';
data shoesizeMen;
	SET shoesize;
	If Sex = "F" then Delete;
	
Proc PRINT data= shoesizeMen;
	RUN;
	
Title 'Females Data';
data shoesizeFemale;
	SET shoesize;
	If Sex = "M" then Delete;
	
Proc PRINT data= shoesizeFemale;
	RUN;
	
/* B. Determine the sample regression equation with shoe size as the predictor variable for height.*/	
Title 'Mens Regression Line';
ods graphics on;
   proc reg data=shoesizeMen plots=residualbypredicted;
      model Height = Size / r clm cli;
      Footnote 'ŷ = 61.67176 + 0.89313x'; /*Added After Calculation for write up*/
   run;
   
/* C. Find and interpret the standard error of the estimate.*/
/*This portion of the assignment has been completed using the SSE which we were given in part B's Calculations and used in excel to calculate Se = sqrt(SSE/(n-1))*/
/*Roughly speaking, the predicted height of a male in the sample differs, on average, from the observed height by 2.155 .*/

/* D. Test whether shoe size is useful for predicting height.*/

/*I.Correlation*/
Title 'Correlation between Height and Size';
PROC CORR DATA= shoesizeMen fisher;
    VAR Size Height;
RUN;

/*Repeating b-j for Female Data Set.*/

Title 'Womens Regression Line';
ods graphics on;
   proc reg data=shoesizeFemale plots=residualbypredicted;
      model Height = Size / r clm cli;
      footnote 'ŷ = 55.725 + 1.267x'; /*added after calculation*/
   run;
   
/*I.Correlation*/
Title 'Correlation between Height and Size';
PROC CORR DATA= shoesizeFemale fisher;
    VAR Size Height;
RUN;