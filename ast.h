#ifndef AST_H
#define AST_H

#include <vector>
#include <variant>
#include <string>
#include <iostream>
#include <memory>

namespace ast
{
typedef std::variant<int, double, bool, std::string> LiteralVariant;

enum class NodeType: int {
    PROGRAM,
    LIST,
    VECTOR,
    LITERAL
};

enum class LiteralType : int {
    BOOL,
    NIL,
    STRING,
    REAL,
    INTEGER,
    IDENT,
    RESERVED
};

class Node {
public:
    std::vector<std::shared_ptr<Node>> children;

    virtual int type() const = 0;
    virtual void print(std::ostream &out) const = 0;
    virtual ~Node() {};
};

typedef std::shared_ptr<Node> NodePtr;

class ProgramNode : public Node {
public:
    int type() const;
    void print(std::ostream &out) const;
};

typedef std::shared_ptr<ProgramNode> ProgramNodePtr;

class ListNode : public Node {
public:
    int type() const;
    void print(std::ostream &out) const;
};

typedef std::shared_ptr<ListNode> ListNodePtr;

class VectorNode : public Node {
public:
    int type() const;
    void print(std::ostream &out) const;
};

typedef std::shared_ptr<VectorNode> VectorNodePtr;

class LiteralNode : public Node {
public:
    LiteralType token_type;
    LiteralVariant literal;
    LiteralNode(LiteralType type, LiteralVariant literal);
    int type() const;
    void print(std::ostream &out) const;
};

typedef std::shared_ptr<LiteralNode> LiteralNodePtr;
NodePtr node(NodeType type);
NodePtr node(LiteralType type, LiteralVariant literal);

std::ostream &operator<<(std::ostream &out, const NodePtr &p);
} /* namespace ast */
#endif /* AST_H */
