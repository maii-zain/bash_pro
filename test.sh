#!/bin/bash
read -p "Enter database you want to connect with " connect_db
read -p "Enter your table name : " db_table
        db_table=`echo $db_table | tr " " "_"` 
        if [[ $db_table =~ ^[a-zA-Z]{1}$ ]];then
           echo "table must contain at least 2 char .. press 1 to enter name again"
        elif [[ ${#db_table} -gt 20 ]];then
           echo "To much name .. press 1 to enter name again"  
        elif [[ $db_table = [0-9]* ]];then
            echo "table cant start with number .. press 1 to enter name again"  
        elif [[ $db_table = "" ]];then
            echo "Empty name ! .. press 1 to enter name again" 
        elif [[ $db_table =~ ['!@#$%^&*:/\\()+'] ]];then
            echo "table cant contain special characters .. press 1 to enter name again"   
        else
            if [[ -e db/$connect_db/$db_table ]];then
            echo "This Name already exist"
            source minuofTable.sh
            else 
            touch db/$connect_db/$db_table 
            # nm="meta"
            # metaa="$nm"-"$db_table"
            # touch db/$connect_db/$metaa
            echo "Your table created <3"
            fi          
        fi  

    if [[ -e db/$connect_db/$db_table ]];then
     cd db
     cd $connect_db
     columns="ID:"
        echo "~~~~~~TableID is created automatically in the first field as (PK)~~~~~~~~~~"
                echo "~~~~~~~~Table columns can't exceed 5 columns~~~~~~~~~~"
                FieldNumber=2
                function insert {
                    
                     read -p "Enter field number $FieldNumber:" field

                        while  [[ $field =~ ^[a-zA-Z]{1}$ ]] || [[ ${#field} -gt 20 ]] ||  [[ $field = [0-9]* ]] || [[ $field = "" ]] || [[ $field =~ ['!@#$%^&*:/\\()+'] ]]
                            do
                                echo  "Invalid input! enter your value again"
                                read field
                            done
                        export $field
                        count=1 
                        
                        if echo "$columns" | grep -q ":$field:"; then
                            echo "Field named $field already exists."
                            
                            insert
                       
                        else
                        columns+="$field"
                    
                        echo "Choose the datatype:"
                        select data in "Integer" "String"
                        do
                            case $REPLY in
                                1 ) datatype+="int"; break;;
                                2 ) datatype+="string";   break;;
                                * ) echo "Invalid choice";
                            esac
                        done
                        echo "Choose it can be NULL or not:"
                        select prop in "NULL" "Not NULL"
                        do
                            case $REPLY in
                                1 ) datatype+="";  break;;
                                2 ) datatype+=" (Not NULL)";  break;;
                                * ) echo "Invalid choice";
                            esac
                        done
                    

                        echo "Insert another field?"
                        select check in "Yes" "No"
                        do
                            case $REPLY in
                                1 )
                                if [ $FieldNumber -le 5 ]
                                then
                                ((FieldNumber=FieldNumber+1)) ;
                                columns+=":";datatype+=":"; 
                                insert ; 
                                fi
                                break ;;
                                
                                2 ) 
                                
                                break
                                
                                ;;
                                * ) echo "Invalid choice";
                            esac
                        done
                        fi
                        
                    }
                    insert
                    echo $columns>>$db_table
                    echo $datatype>>$db_table 
                    
                    
                    cd ..
                    
                    cd ..
                    source minuofTable.sh


   fi   












   #!/bin/bash
select val in "Insert into table" "Update Table" "De1m Table"  "search in table" "Exit"

do
    case $REPLY in 
    1)
    
    #cd ..;
    source insertTabledata.sh
    ;;
    2)
    
    source ./updateDataintable.sh
    #cd .. ;
    
    ;;
    3)
    
    source ./delete_from_table.sh
    #cd .. ;
    
    ;;
    4)
    
    source .select_from_table.sh
    #cd ..;
    
    ;;
    5)
    
    #cd ..;
    echo "GoodBye :)" ; break 100
    ;;
     *) 
    echo "please enter a valid input";;
    esac 
done

               
            
     