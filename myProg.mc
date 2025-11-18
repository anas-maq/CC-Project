empty myProg()
{
    Digi num = 5;;
    Point float_val = 15.5;;
    Word character = 'B';

    Suppose(num > 3)
    {
        show("Number is greater than 3.");;
    }
    Suppose_else
    {
        show("Number is smaller.");;
    }

    Because_of(Digit x = 0; x < 5; x = x + 1)
    {
        Suppose(x == 4)
        {
            STOP;;
        }
        show(x);;
    }

    Digit reg_no;;
    show("Enter your Registration number:");;
    take(reg_no);;

    show("This is your Registration number: %d", reg_no);;

    Digit A = 4, B = 2;;

    show("A + B = %d", A add B);;
    show("A - B = %d", A subtract B);;
    show("A * B = %d", A mult B);;
    show("A / B = %d", A divide B);;   

    give_out 0;;
}

