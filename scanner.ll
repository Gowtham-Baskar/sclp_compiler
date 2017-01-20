%filenames="scanner"
%lex-source="scanner.cc"

digit [0-9]
alphabet [a-zA-Z_]
//number([-+]{digit}+)|({digit}+)
number ([-]{digit}+)|({digit}+)
identifier {alphabet}({alphabet}|{digit})*

%%
//ADD YOUR CODE HERE


"int"	{
		//printf("int found\n");
		store_token_name("INTEGER");
		return Parser::INTEGER;
	}

"="	{
		//printf("equal to found\n");
		store_token_name("ASSIGN_OP");
		return Parser::ASSIGN;
	}

"void"	{
		//printf("void found\n");
		store_token_name("VOID");
		return Parser::VOID;	
	}

"return" {
		//printf("return found\n");
		store_token_name("RETURN");
		return Parser::RETURN;
	 }
			
{identifier} {
		//std::cout<<"identifier found "<<matched()<<endl;
		ParserBase::STYPE__ *val = getSval();      
		std::string * matched_str = new string(matched()); 	
		val -> string_value = matched_str;
		store_token_name("NAME");
		return Parser::NAME; 
             }

{number} {	
		//std::cout<<"number found "<<matched()<<endl;
		ParserBase::STYPE__ *val = getSval();      
	        val -> integer_value = atoi(matched().c_str());
		store_token_name("NUM");
		return Parser::INTEGER_NUMBER; 
   	}

[\(\);{}] {
		//std::cout<<"other found "<<matched()<<endl;	
		store_token_name("META CHAR");
		return matched()[0];
	 }

\n    		|
";;".*  	|
[ \t]*";;".*	|
[ \t]*"//".*	|
[ \t]		{
			if (command_options.is_show_tokens_selected())
				ignore_token();
		}

.		{ 
			string error_message;
			error_message =  "Illegal character `" + matched();
			error_message += "' on line " + lineNr();
			
			CHECK_INPUT(CONTROL_SHOULD_NOT_REACH, error_message, lineNr());
		}
