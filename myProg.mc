empty myProg()
{
   
    DIgit reg_no;;
    show("Enter your Registration number:");;
    take(reg_no);;

    shOw("This is your Registration number: %d", reg_no);;

    Digit A = 4, B = 2;;

    show("A plus B = %d", A add B);;
    show("A minus B = %d", A subtract B);;
    show("A multiply B = %d", A mult B);;
    show("A divide B = %d", A divide B);;   
    
    Digit num = 5;;
    Point float_val = 15.5;;
    Wor character = 'B';;

    Suppose(num equal_to 3)
    {
        show("Number is equal to 3.");;
    }
    Suppose_else
    {
        show("Number is not equal to 3.");;
    }

    Because_of(Digit x = 0;; x < 5;; x = x + 1)
    {
        Suppose(x equal_to 4)
        {
            STOP;;
        }
        show(x);;
    }
    give_out 0;;
}

