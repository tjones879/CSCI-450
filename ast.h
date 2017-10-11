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
    ATOMS,
    LIST,
    VECTOR,
    MAP,
    LITERAL
};

enum class LiteralType : int {
    BOOL,
    NIL,
    STRING,
    REAL,
    INTEGER,
    IDENT,
    KEYWORD,
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

class AtomsNode : public Node {
public:
    int type() const;
    void print(std::ostream &out) const;
};

typedef std::shared_ptr<AtomsNode> AtomsNodePtr;

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

class MapNode : public Node {
public:
    int type() const;
    void print(std::ostream &out) const;
};

typedef std::shared_ptr<MapNode> MapNodePtr;

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
