NAME        = program

SRC_DIR     = src
INC_DIR     = inc
OBJ_DIR     = obj

FILES       = main.c
SRCS        = $(addprefix $(SRC_DIR)/, $(FILES))
OBJS        = $(SRCS:$(SRC_DIR)/%.c=$(OBJ_DIR)/%.o)
DEPS        = $(OBJS:.o=.d)

CC          = cc
CFLAGS      = -Wall -Wextra -Werror
CPPFLAGS    = -I $(INC_DIR)

RM          = rm -rf

all: $(NAME)

$(NAME): $(OBJS)
  	$(CC) $(CFLAGS) $(OBJS) -o $(NAME)

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.c
	@mkdir -p $(OBJ_DIR)
	$(CC) $(CFLAGS) $(CPPFLAGS) -c $< -o $@

run: all
	./$(NAME)

debug: all
	gdb -tui ./$(NAME)

leak: all
	valgrind --leak-check=full --show-leak-kinds=all 

clean:
	$(RM) $(OBJ_DIR)

fclean: clean
	$(RM) $(NAME)

re: fclean all

-include $(DEPS)

.PHONY: all clean fclean re
