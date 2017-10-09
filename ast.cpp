#include "ast.h"

namespace ast
{
template <class T>
void printChildren(std::ostream &out, std::vector<T> children) {
    for (auto node : children)
        out << node << std::endl;
}

int ProgramNode::type() const {
    return static_cast<int>(NodeType::PROGRAM);
}

void ProgramNode::print(std::ostream &out) const {
    out << "program" << std::endl;
    printChildren(out, children);
    out << "end program" << std::endl;
}

int ListNode::type() const {
    return static_cast<int>(NodeType::LIST);
}

void ListNode::print(std::ostream &out) const {
    out << "list (" << std::endl;
    printChildren(out, children);
    out << " )" << std::endl;
}

int VectorNode::type() const {
    return static_cast<int>(NodeType::VECTOR);
}

void VectorNode::print(std::ostream &out) const {
    out << "vector [" << std::endl;
    printChildren(out, children);
    out << " ]" << std::endl;
}

int LiteralNode::type() const {
    return static_cast<int>(NodeType::LITERAL);
}

void LiteralNode::print(std::ostream &out) const {
    std::visit([&out](auto &arg) { out << "literal " << arg << std::endl;}, literal);
}

std::ostream &operator<<(std::ostream &out, const NodePtr &p) {
    p->print(out);
    return out;
};
} /* namespace ast */
